//
//  ResponseInterceptor.swift
//  Networking
//
//  Created by Oğuz Parlak on 18.09.2020.
//  Copyright © 2020 Oğuz Parlak. All rights reserved.
//

import Foundation

open class ResponseInterceptor<Response: Decodable> {
  
  public init() { }
  
  open func intercept(response: Response) -> Response {
    fatalError("intercept(response: Response) must be overriden")
  }
  
  open func interceptOnError(error: AppError) {
    fatalError("intercept(error: HttpError) must be overriden")
  }
  
}
