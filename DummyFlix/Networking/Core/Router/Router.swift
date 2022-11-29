//
//  Router.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public typealias completionHandler<T> = (Result<T, AppError>) -> Void
// swiftlint:enable type_name

public protocol NetworkRouter: AnyObject {
  associatedtype Endpoint: EndpointType
  func request<T: Decodable>(_ route: Endpoint,
                             requestInterceptor: RequestInterceptor?,
                             responseInterceptor: ResponseInterceptor<T>?,
                             completion: @escaping completionHandler<T>)
  func cancel()
}

public class Router<Endpoint: EndpointType>: NetworkRouter {
  
  public init() { }
  
  private var task: URLSessionTask?
  
  public func request<T: Decodable>(_ route: Endpoint,
                                    requestInterceptor: RequestInterceptor? = nil,
                                    responseInterceptor: ResponseInterceptor<T>? = nil,
                                    completion: @escaping completionHandler<T>) {
    
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 30.0
    sessionConfig.timeoutIntervalForResource = 30.0
    
    let session = URLSession(configuration: sessionConfig,
                             delegate: nil,
                             delegateQueue: OperationQueue.main)
    
    guard var request = try? route.buildRequest() else {
      return
    }
    
    if let requestInterceptor = requestInterceptor {
      request = requestInterceptor.intercept(request: request)
    }
    
    Logger.log(request: request)
    
    task = session.dataTask(with: request, completionHandler: { data, response, error in
      DispatchQueue.main.async {
        if (error as? URLError)?.code == .timedOut {
          completion(.failure(.custom(code: "Request timed out")))
          return
        }
        if let response = response as? HTTPURLResponse {
          let statusCode = response.statusCode
          guard let responseData = data else { return }
          switch statusCode {
          case 200, 201: // Success
            do {
              Logger.log(response: response, bodyData: data)
              let apiResponse = try JSONDecoder(withDateDecodingStrategy: .iso8601).decode(T.self, from: responseData)
              if let responseInterceptor = responseInterceptor {
                completion(.success(responseInterceptor.intercept(response: apiResponse)))
                return
              }
              completion(.success(apiResponse))
            } catch {
              debugPrint(error)
              completion(.failure(.unableToDecode))
            }
          default: // Failure
            do {
              Logger.log(response: response, bodyData: data)
              let errorResponse = try JSONDecoder(
                withDateDecodingStrategy: .iso8601
              ).decode(ErrorResponse.self, from: responseData)
              guard let code = errorResponse.code else {
                completion(.failure(.unknown))
                return
              }
              var error: AppError!
              switch statusCode {
              case 401:
                error = .authentication(code: code)
              case 403:
                error = .authorization(code: code)
              case 404:
                error = .notFound(code: code)
              default:
                error =	.custom(code: code)
              }
              if let responseInterceptor = responseInterceptor {
                responseInterceptor.interceptOnError(error: error)
              }
              completion(.failure(error))
            } catch {
              debugPrint(error)
              completion(.failure(.unableToDecode))
            }
          }
        } else {
          completion(.failure(.unknown))
        }
      }
    })
    
    task?.resume()
  }
  
  public func cancel() {
    task?.cancel()
  }
  
}
