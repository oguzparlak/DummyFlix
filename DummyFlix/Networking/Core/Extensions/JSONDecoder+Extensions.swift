//
//  JSONDecoder+Extensions.swift
//  Networking
//
//  Created by Oğuz Parlak on 26.12.2020.
//  Copyright © 2020 Oğuz Parlak. All rights reserved.
//

import Foundation

public extension JSONDecoder {
  
  convenience init(withDateDecodingStrategy strategy: DateDecodingStrategy) {
    self.init()
    self.dateDecodingStrategy = strategy
  }
  
}
