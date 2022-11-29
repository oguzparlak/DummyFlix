//
//  DummyFlixEndpoint.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public protocol DummyFlixEndpoint: EndpointType { }

public extension DummyFlixEndpoint {

  var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }
  
  public var parameters: Parameters {
    return [:]
  }
}
