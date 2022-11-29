//
//  DynamicHeightedCollectionView.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation
import UIKit

public final class DynamicHeightedCollectionView: UICollectionView {
  public override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, intrinsicContentSize) {
      self.invalidateIntrinsicContentSize()
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
