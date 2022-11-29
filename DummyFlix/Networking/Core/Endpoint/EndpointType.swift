//
//  EndpointType.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

public protocol EndpointType {
  var baseURL: URL { get }
  var path: String { get }
  var parameters: Parameters { get }
  var httpMethod: HTTPMethod { get }
  var httpTask: HTTPTask { get }
  var httpHeaders: [String: String] { get }
}

public extension EndpointType {
  
  var httpHeaders: [String: String] {
    return [:]
  }
  
  func buildRequest() throws -> URLRequest {
    var request = URLRequest(url: baseURL.appendingPathComponent(path),
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 60.0)
    request.allHTTPHeaderFields = httpHeaders
    request.httpMethod = httpMethod.rawValue
    
    do {
      switch httpTask {
      case .request: break
      case .requestParameters(let parameters,
                              let encoding):
        
        try configureParameters(parameters: parameters,
                                encoding: encoding,
                                request: &request)
        
      }
      
      return request
    } catch {
      throw error
    }
  }
  
  private func configureParameters(parameters: Parameters, encoding: ParameterEncoding, request: inout URLRequest) throws {
    try encoding.encode(urlRequest: &request, parameters: parameters)
  }
  
}
