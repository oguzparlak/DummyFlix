//
//  HomeTableViewManager.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit
import SkeletonView

public final class HomeTableViewManager: NSObject {
  
  // MARK: - Variables
  
  public var components: [Component] {
    return presentation.components.sorted { $0.order < $1.order }
  }
  
  public var navigationVisibilityHandler: ((Bool) -> Void)? = nil
  
  private lazy var presentation = HomeUIPresentation()
  private var isLoading: Bool = false
  
  // MARK: - Methods
  
  func setLoading(_ loading: Bool) {
    isLoading = loading
  }
  
  func setPresentation(_ presentation: HomeUIPresentation) {
    self.presentation = presentation
  }
}

// MARK: - UITableViewDataSource

extension HomeTableViewManager: SkeletonTableViewDataSource {
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = collectionSkeletonView(
      tableView,
      skeletonCellForRowAt: indexPath
    ) else {
      return UITableViewCell()
    }
    return cell
  }
  
  public func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
    if components.isEmpty { return UITableViewCell() }
    let component = components[indexPath.row]
    switch component.component {
    case .header(let viewModel):
      let cell = skeletonView.dequeueReusableCell(
        ofType: HomeHeaderCell.self,
        forIndexPath: indexPath
      )
      updateUIOnLoading(with: cell)
      cell.configure(with: viewModel)
      return cell
    case .mediaList(let viewModel):
      let cell = skeletonView.dequeueReusableCell(
        ofType: MediaListCell.self,
        forIndexPath: indexPath
      )
      updateUIOnLoading(with: cell)
      viewModel.isLoading = isLoading
      cell.configure(with: viewModel)
      return cell
    }
  }
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if cell is HomeHeaderCell {
      navigationVisibilityHandler?(false)
    }
  }
  
  public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if cell is HomeHeaderCell {
      navigationVisibilityHandler?(true)
    }
  }
  
  public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return HomeHeaderCell.reuseIdentifier
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return components.count
  }
}

// MARK: - UITableViewDelegate

extension HomeTableViewManager: UITableViewDelegate {
  
}

// MARK: - HomeUIPresentation

public final class HomeUIPresentation {
  public var components: [Component] = []
}

// MARK: - Component

public struct Component {
  public let order: Int
  public let component: HomeComponent
}

public enum HomeComponent {
  case header(HomeHeaderCell.ViewModel)
  case mediaList(MediaListCell.ViewModel)
}

// MARK: - Private

private extension HomeTableViewManager {
  
  func updateUIOnLoading(with cell: UITableViewCell) {
    if isLoading {
      cell.showAnimatedGradientSkeleton(transition: .none)
    } else {
      cell.hideSkeleton(reloadDataAfter: true, transition: .none)
    }
  }
}
