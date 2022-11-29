//
//  APIKeyInterceptor.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public final class APIKeyInterceptor: RequestInterceptor {

  private let apiKey: String
  
  public init(apiKey: String) {
    self.apiKey = apiKey
  }
  
  public func intercept(request: URLRequest) -> URLRequest {
    guard let url = request.url else { return request }
    var urlRequest = request
    if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
      var queryItems = urlComponents.queryItems ?? []
      queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
      urlComponents.queryItems = queryItems
      urlRequest.url = urlComponents.url
    }
    return urlRequest
  }
}
