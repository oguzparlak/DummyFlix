//
//  HomeViewModel.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation

public protocol HomeViewModelProtocol {
  func load() async throws -> HomeUIPresentation
  func fetchFeaturedShow() async -> HomeHeaderCell.ViewModel
  func dummyPresentation() -> HomeUIPresentation
}

public final class HomeViewModel: HomeViewModelProtocol {
  
  // MARK: - Variables
  
  private var isLoading: Bool = true
  
  // MARK: - Injected Variables
  
  private let homeService: HomeServiceProtocol
  
  // MARK: - Init
  
  public init(homeService: HomeServiceProtocol = HomeService()) {
    self.homeService = homeService
  }
  
  // MARK: - Methods
  
  public func load() async throws -> HomeUIPresentation {
    try await withThrowingTaskGroup(of: Component.self, body: { group in
      let presentation = HomeUIPresentation()
      group.addTask {
        let headerViewModel = await self.fetchFeaturedShow()
        return .init(order: 1, component: .header(headerViewModel))
      }
      group.addTask {
        let mediaViewModel = await self.fetchMedia(mediaType: .topRatedTV)
        return .init(order: 2, component: .mediaList(mediaViewModel))
      }
      group.addTask {
        let mediaViewModel = await self.fetchMedia(mediaType: .currentlyLiveOnTV)
        return .init(order: 3, component: .mediaList(mediaViewModel))
      }
      group.addTask {
        let mediaViewModel = await self.fetchMedia(mediaType: .topRatedMovies)
        return .init(order: 4, component: .mediaList(mediaViewModel))
      }
      group.addTask {
        let mediaViewModel = await self.fetchMedia(mediaType: .upcomingMovies)
        return .init(order: 5, component: .mediaList(mediaViewModel))
      }
      group.addTask {
        let mediaViewModel = await self.fetchMedia(mediaType: .popularMovies)
        return .init(order: 6, component: .mediaList(mediaViewModel))
      }
      for try await component in group {
        presentation.components.append(component)
      }
      return presentation
    })
  }
  
  public func dummyPresentation() -> HomeUIPresentation {
    let presentation = HomeUIPresentation()
    presentation.components.append(.init(
      order: 1, component: .header(HomeHeaderCell.ViewModel()))
    )
    presentation.components.append(.init(
      order: 2, component: .mediaList(MediaListCell.ViewModel()))
    )
    presentation.components.append(.init(
      order: 3, component: .mediaList(MediaListCell.ViewModel()))
    )
    return presentation
  }
  
  public func fetchFeaturedShow() async -> HomeHeaderCell.ViewModel {
    guard let media = try? await homeService.popularTVShows().get() else {
      return HomeHeaderCell.ViewModel()
    }
    let results = media.results
    let viewModel = HomeHeaderCell.ViewModel(
      posterImageURL: results.first?.fullBackdropPath ?? "",
      title: results.first?.name ?? ""
    )
    return viewModel
  }
  
  public func fetchMedia(mediaType: MediaType) async -> MediaListCell.ViewModel {
    guard let media = try? await mediaType.media(service: homeService) else {
      return MediaListCell.ViewModel()
    }
    let results = media.results
    let viewModel = MediaListCell.ViewModel()
    viewModel.title = mediaType.title
    viewModel.items = results.map {
      return MediaItemCell.ViewModel(posterImageURL: $0.fullPosterPath)
    }
    return viewModel
  }
}

// MARK: - MediaType

public extension HomeViewModel {
  
  enum MediaType {
    case topRatedTV
    case currentlyLiveOnTV
    case topRatedMovies
    case upcomingMovies
    case popularMovies
    
    var title: String {
      switch self {
      case .topRatedTV:
        return "Top Rated TV Shows"
      case .currentlyLiveOnTV:
        return "Currently Live on TV"
      case .topRatedMovies:
        return "Top Rated Movies"
      case .upcomingMovies:
        return "Upcoming Movies"
      case .popularMovies:
        return "Popular Movies"
      }
    }
    
    func media(service: HomeServiceProtocol) async throws -> Media {
      switch self {
      case .topRatedTV:
        return try await service.topRatedTVShows().get()
      case .currentlyLiveOnTV:
        return try await service.liveOnTV().get()
      case .topRatedMovies:
        return try await service.topRatedMovies().get()
      case .upcomingMovies:
        return try await service.upcomingMovies().get()
      case .popularMovies:
        return try await service.popularMovies().get()
      }
    }
  }
}
