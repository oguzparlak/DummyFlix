//
//  HighlightableButton.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit

public final class HighlightableButton: UIButton {
  
  public override var isHighlighted: Bool {
    get {
      if backgroundColor == .clear { return false }
      return super.isHighlighted
    }
    set {
      if backgroundColor == .clear { return }
      if newValue {
        UIView.animate(withDuration: 0.15) {
          self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
        }
      } else {
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
      }
      super.isHighlighted = newValue
    }
  }
}
