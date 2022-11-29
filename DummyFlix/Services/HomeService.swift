//
//  HomeService.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public struct IgnorableResponse: Decodable {
  
}

public protocol HomeServiceProtocol {
  func popularTVShows() async -> Result<Media, AppError>
  func topRatedTVShows() async -> Result<Media, AppError>
  func liveOnTV() async -> Result<Media, AppError>
  func topRatedMovies() async -> Result<Media, AppError>
  func upcomingMovies() async -> Result<Media, AppError>
  func popularMovies() async -> Result<Media, AppError>
}

public final class HomeService: HomeServiceProtocol {
  
  public init() { }
  
  public func popularTVShows() async -> Result<Media, AppError> {
    await HomeEndpoint.popularTvShows.retrieve()
  }
  
  public func topRatedTVShows() async -> Result<Media, AppError> {
    await HomeEndpoint.topRatedTvShows.retrieve()
  }
  
  public func liveOnTV() async -> Result<Media, AppError> {
    await HomeEndpoint.currentlyLiveOnTV.retrieve()
  }
  
  public func topRatedMovies() async -> Result<Media, AppError> {
    await HomeEndpoint.topRatedMovies.retrieve()
  }
  
  public func upcomingMovies() async -> Result<Media, AppError> {
    await HomeEndpoint.upcomingMovies.retrieve()
  }
  
  public func popularMovies() async -> Result<Media, AppError> {
    await HomeEndpoint.popularMovies.retrieve()
  }
}
