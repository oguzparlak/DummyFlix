//
//  MediaListCell.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 29.11.2022.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

public final class MediaListCell: Cell {
  
  // MARK: - ViewModel
  
  public final class ViewModel {
    public var title: String = ""
    public var items: [MediaItemCell.ViewModel] = MediaItemCell.dummy()
    public var isLoading: Bool = true
  }
  
  // MARK: - Variables
  
  private lazy var viewModel = ViewModel()
  
  // MARK: - Views
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .label
    label.isSkeletonable = true
    return label
  }()
  
  private lazy var collectionView: DynamicHeightedCollectionView = {
    let collectionView = DynamicHeightedCollectionView(
      frame: bounds,
      collectionViewLayout: layout
    )
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.isSkeletonable = true
    return collectionView
  }()
  
  private lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 16
    layout.sectionInset = .init(top: .zero, left: 16, bottom: .zero, right: 16)
    layout.itemSize = .init(width: 128.31, height: 190)
    layout.scrollDirection = .horizontal
    return layout
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
    self.viewModel = viewModel
    titleLabel.text = viewModel.title
    collectionView.reloadData()
    setupConstraints()
  }
}

// MARK: - Private

private extension MediaListCell {
  
  func initialize() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(collectionView)
    collectionView.registerClass(MediaItemCell.self)
    setupConstraints()
  }
  
  func setupConstraints() {
    titleLabel.snp.remakeConstraints {
      $0.top.equalToSuperview().offset(32)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    collectionView.snp.remakeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(190)
      $0.bottom.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension MediaListCell: UICollectionViewDataSource {
  
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    viewModel.items.count
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let itemViewModel = viewModel.items[indexPath.row]
      let itemCell: MediaItemCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
      itemCell.configure(with: itemViewModel)
      itemCell.isSkeletonable = true
      if viewModel.isLoading {
        itemCell.showAnimatedGradientSkeleton(transition: .none)
      } else {
        itemCell.hideSkeleton()
      }
      return itemCell
  }
}
