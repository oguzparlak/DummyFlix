//
//  EndpointType+Extensions.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public extension EndpointType {
  
  func retrieve<T: Decodable>(
    requestInterceptor: RequestInterceptor? = APIKeyInterceptor(
      apiKey: "faed2234cc0d9c726c1db914559b893d"
    ),
    responseInterceptor: ResponseInterceptor<T>? = nil,
    resultHandler: @escaping (Result<T, AppError>) -> Void
  ) {
    let router = Router<Self>()
    router.request(
      self, requestInterceptor: requestInterceptor,
      responseInterceptor: responseInterceptor
    ) { (response: Result<T, AppError>) in
      resultHandler(response)
    }
  }

  func retrieve<T: Decodable>() async -> Result<T, AppError> {
    await withCheckedContinuation { continuation in
      retrieve { result in
        DispatchQueue.main.async {
          continuation.resume(returning: result)
        }
      }
    }
  }
}
