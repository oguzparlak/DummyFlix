//
//  LoadableCell.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit
import SkeletonView

open class Cell: UITableViewCell {
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    isSkeletonable = true
    selectionStyle = .none
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
