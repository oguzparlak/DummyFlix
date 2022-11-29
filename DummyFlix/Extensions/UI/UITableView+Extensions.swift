//
//  UITableView+Extensions.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit

/// ReusableView protocol.
public protocol ReusableView: AnyObject {}

/// ReusableView extension, Provides reuseIdentifier from class name.
public extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  func prepareForReuse() {}
}

/// Describable protocol, Adds a typeName to describe self.
public protocol Describable {
  var typeName: String { get }
  static var typeName: String { get }
}

/// Provides an automatic implementation of protocol.
public extension Describable {
  var typeName: String {
    return String(describing: self)
  }
  
  static var typeName: String {
    return String(describing: self)
  }
}

/// Extension of Describable. Adds Describable to NSObject derived classes.
public extension Describable where Self: NSObjectProtocol {
    
  var typeName: String {
    let selfType = type(of: self)
    return String(describing: selfType)
  }
}

/// Extends UITableViewHeaderFooterView with ReusableView
extension UITableViewHeaderFooterView: ReusableView { }

/// Extends UITableViewCell with ReusableView
extension UITableViewCell: ReusableView { }

/// Extension of UITableView. Adds ease of use and ability to remove header-footer shadows.
public extension UITableView {
  
  /// Registers  Class for any UITableViewCell subclass.
  func registerCell<T: UITableViewCell>(_: T.Type) {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type,
                                               forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
      let message = "🚨 Could not dequeue cell with identifier: \(T.reuseIdentifier). \n👨‍🏫Cell type and reuse identifier must be same"
      print(message)
      fatalError(message)
    }
    return cell
  }
}
