//
//  MediaItemCell.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

public final class MediaItemCell: UICollectionViewCell {
  
  // MARK: - Variables
  
  public override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        UIView.animate(withDuration: 0.15) {
          self.subviews.forEach { $0.alpha = 0.5 }
        }
      } else {
        UIView.animate(withDuration: 0.15) {
          self.subviews.forEach { $0.alpha = 1 }
        }
      }
    }
  }
  
  // MARK: - Views
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.layer.masksToBounds = true
    imageView.isSkeletonable = true
    return imageView
  }()
  
  // MARK: - ViewModel
  
  public struct ViewModel {
    public let posterImageURL: String
  }
  
  // MARK: - Init
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Methods
  
  public func configure(with viewModel: ViewModel) {
    imageView.loadImage(with: viewModel.posterImageURL)
  }
}

// MARK: - Private

private extension MediaItemCell {
  
  func initialize() {
    contentView.addSubview(imageView)
    setupConstraints()
  }
  
  func setupConstraints() {
    imageView.snp.makeConstraints {
      $0.height.equalTo(190)
      $0.width.equalTo(128.31)
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - Dummy

public extension MediaItemCell {
  
  static func dummy() -> [MediaItemCell.ViewModel] {
    return Array(
      repeating: MediaItemCell.ViewModel(
        posterImageURL: ""
      ),
      count: 5
    )
  }
}
