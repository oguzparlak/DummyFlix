//
//  RequestInterceptor.swift
//  Networking
//
//  Created by Oğuz Parlak on 18.09.2020.
//  Copyright © 2020 Oğuz Parlak. All rights reserved.
//

import Foundation

public protocol RequestInterceptor {
  func intercept(request: URLRequest) -> URLRequest
}
