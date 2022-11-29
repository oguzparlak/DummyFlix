//
//  ParameterEncoding.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
  func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum NetworkError: String, Error {
  case parametersNil = "Parameters were nil."
  case encodingFailed = "Parameter encoding failed."
  case missingURL = "URL is nil."
}

public enum ParameterEncoding {
  
  case urlEncoding
  case jsonEncoding
  
  public func encode(urlRequest: inout URLRequest,
                     parameters: Parameters?) throws {
    switch self {
    case .urlEncoding:
      guard let urlParameters = parameters else { return }
      try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
    case .jsonEncoding:
      guard let bodyParameters = parameters else { return }
      try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
    }
  }
  
}
