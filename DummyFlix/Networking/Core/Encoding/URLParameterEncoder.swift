//
//  URLParameterEncoder.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
  
  func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    
    guard let url = urlRequest.url else { throw NetworkError.missingURL }
    
    if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
      
      urlComponents.queryItems = [URLQueryItem]()
      
      parameters.forEach({
        let queryItem = URLQueryItem(name: $0, value: "\($1)".percentEncoded())
        urlComponents.queryItems?.append(queryItem)
      })
      
      urlRequest.url = urlComponents.url
    }
    
  }
  
}

private extension String {
  
  func percentEncoded() -> String? {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
  }
  
}
