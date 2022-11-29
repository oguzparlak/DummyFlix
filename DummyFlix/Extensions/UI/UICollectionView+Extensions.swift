//
//  UICollectionView+Extensions.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation
import UIKit

/// Extends UICollectionReusableView with ReusableView
extension UICollectionReusableView: ReusableView { }

public extension UICollectionView {
  
  /// Registers Class for any UICollectionViewCell subclass.
  func registerClass<T: UICollectionViewCell>(_: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  /**
      Dequeus reusable CollectionViewCell and Returns.
      - Parameter indexPath: Index path of cell.
      - Returns: CollectionViewCell for given index path.
   */
  func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("🚨 Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
}
