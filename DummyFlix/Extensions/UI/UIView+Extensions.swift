//
//  UIView+Extensions.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit

public extension UIView {
  
  static func getSubviewsOf<T: UIView>(view: UIView) -> [T] {
    var subviews = [T]()
    for subview in view.subviews {
      subviews += getSubviewsOf(view: subview) as [T]
      if let subview = subview as? T {
        subviews.append(subview)
      }
    }
    return subviews
  }
}
