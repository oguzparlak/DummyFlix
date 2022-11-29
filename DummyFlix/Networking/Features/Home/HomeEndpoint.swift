//
//  HomeEndpoint.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public enum HomeEndpoint: DummyFlixEndpoint {
  
  case popularTvShows
  case topRatedTvShows
  case currentlyLiveOnTV
  case topRatedMovies
  case upcomingMovies
  case popularMovies
  
  public var path: String {
    switch self {
    case .popularTvShows:
      return "/tv/popular"
    case .topRatedTvShows:
      return "/tv/top_rated"
    case .currentlyLiveOnTV:
      return "/tv/on_the_air"
    case .topRatedMovies:
      return "/movie/top_rated"
    case .upcomingMovies:
      return "/movie/upcoming"
    case .popularMovies:
      return "/movie/popular"
    }
  }
  
  public var httpMethod: HTTPMethod {
    return .get
  }
  
  public var httpTask: HTTPTask {
    return .request
  }
}
