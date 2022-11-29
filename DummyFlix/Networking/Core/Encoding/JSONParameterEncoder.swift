//
//  JSONParameterEncoder.swift
//  Networking
//
//  Created by Oguz Parlak on 15.01.2019.
//  Copyright © 2019 Networking. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
  
  func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    do {
      let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonAsData
    } catch {
      throw NetworkError.encodingFailed
    }
  }
  
}
