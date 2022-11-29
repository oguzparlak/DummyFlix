//
//  HomeHeaderCell.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

public final class HomeHeaderCell: Cell {
  
  // MARK: - ViewModel
  
  public struct ViewModel {
    public var posterImageURL: String = ""
    public var title: String = ""
    public var playButtonTitle: String = "PLAY"
  }
  
  // MARK: - Views
  
  private lazy var posterImageView: UIImageView = {
    let posterImageView = UIImageView()
    posterImageView.contentMode = .scaleAspectFill
    return posterImageView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 39)
    label.textColor = .label
    label.textAlignment = .center
    label.isSkeletonable = true
    return label
  }()
  
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.setVerticalGradientBackground(
      colors: [
        UIColor.black.withAlphaComponent(0).cgColor,
        UIColor.black.withAlphaComponent(0.50).cgColor,
        UIColor.black.cgColor
      ],
      locations: [0, 0.5, 1]
    )
    return gradientView
  }()
  
  private lazy var buttonStack: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    stackView.isSkeletonable = true
    return stackView
  }()
  
  private lazy var addToListButton: HighlightableButton = {
    let addToListButton = HighlightableButton()
    addToListButton.tintColor = .white
    addToListButton.setImage(Resources.Image.icnAddToList, for: .normal)
    addToListButton.isSkeletonable = true
    return addToListButton
  }()
  
  private lazy var playButton: HighlightableButton = {
    let playButton = HighlightableButton()
    playButton.layer.cornerRadius = 8
    playButton.backgroundColor = .red
    playButton.isSkeletonable = true
    playButton.setImage(Resources.Image.icnPlay, for: .normal)
    playButton.imageEdgeInsets = .init(top: .zero, left: -4, bottom: .zero, right: 30)
    playButton.contentEdgeInsets = .init(top: 14, left: 19, bottom: 14, right: 19)
    return playButton
  }()
  
  private lazy var infoButton: HighlightableButton = {
    let infoButton = HighlightableButton()
    infoButton.isSkeletonable = true
    infoButton.tintColor = .white
    infoButton.setImage(Resources.Image.icnInfo, for: .normal)
    return infoButton
  }()
  
  // MARK: - Init
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Methods
  
  public func configure(with viewModel: ViewModel) {
    posterImageView.loadImage(with: viewModel.posterImageURL)
    titleLabel.text = viewModel.title
    playButton.setTitle(viewModel.playButtonTitle, for: .normal)
  }
}

// MARK: - Private

private extension HomeHeaderCell {
  
  func initialize() {
    contentView.addSubview(posterImageView)
    contentView.addSubview(gradientView)
    contentView.addSubview(playButton)
    contentView.addSubview(buttonStack)
    contentView.addSubview(titleLabel)
    buttonStack.addArrangedSubview(addToListButton)
    buttonStack.addArrangedSubview(playButton)
    buttonStack.addArrangedSubview(infoButton)
    setupConstraints()
  }
  
  func setupConstraints() {
    posterImageView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.height.equalTo(UIScreen.main.bounds.width)
    }
    titleLabel.snp.makeConstraints {
      $0.bottom.equalTo(posterImageView.snp.bottom).offset(-16)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    gradientView.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(posterImageView.snp.bottom)
    }
    buttonStack.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.top.equalTo(posterImageView.snp.bottom).offset(16)
      $0.bottom.equalToSuperview()
    }
  }
  
}
