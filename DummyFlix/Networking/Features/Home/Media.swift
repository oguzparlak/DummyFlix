//
//  Media.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation

public struct Media: Decodable {
  public let results: [MediaResult]
}

public struct MediaResult: Decodable {
  public let backdropPath: String?
  public let posterPath: String?
  public let name: String?
  
  public var fullPosterPath: String {
    if let posterPath = posterPath {
      return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    return ""
  }
  
  public var fullBackdropPath: String {
    if let backdropPath = backdropPath {
      return "https://image.tmdb.org/t/p/original\(backdropPath)"
    }
    return ""
  }
  
  private enum CodingKeys: String, CodingKey {
    case backdropPath = "backdrop_path"
    case posterPath = "poster_path"
    case name
  }
}
