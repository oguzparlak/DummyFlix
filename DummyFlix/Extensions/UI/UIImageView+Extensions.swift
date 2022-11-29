//
//  UIImageView+Extensions.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
  
  func loadImage(with url: String) {
    guard let url = URL(string: url) else { return }
    kf.setImage(with: url)
  }
}
