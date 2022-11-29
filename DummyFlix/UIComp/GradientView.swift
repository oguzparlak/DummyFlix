//
//  GradientView.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit

public final class GradientView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  private func setupView() {
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  public override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
}

public extension GradientView {

  func setVerticalGradientBackground(
    colors: [CGColor],
    locations: [CGFloat] = [0, 1]
  ) {
    setGradientBackground(
      colors: colors,
      locations: locations,
      startPoint: .init(x: 0.5, y: 0),
      endPoint: .init(x: 0.5, y: 1)
    )
  }

  func setHorizontalGradientBackground(
    colors: [CGColor],
    locations: [CGFloat] = [0, 1]
  ) {
      setGradientBackground(
        colors: colors,
        locations: locations,
        startPoint: .init(x: 0, y: 0.5),
        endPoint: .init(x: 1, y: 0.5)
      )
  }

  func setGradientBackground(
    colors: [CGColor],
    locations: [CGFloat],
    startPoint: CGPoint,
    endPoint: CGPoint
  ) {

    guard let gradientLayer = self.layer as? CAGradientLayer else {
      return
    }

    gradientLayer.colors = colors
    gradientLayer.locations = locations.map { $0 as NSNumber }
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.frame = bounds
  }
}
