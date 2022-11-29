//
//  ViewController.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import UIKit

public final class HomeController: UIViewController {
  
  // MARK: - Views
  
  private lazy var refreshControl = UIRefreshControl()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .black
    tableView.contentInset = .zero
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.automaticallyAdjustsScrollIndicatorInsets = false
    tableView.contentInsetAdjustmentBehavior = .never
    return tableView
  }()
  
  // MARK: - Variables
  
  private lazy var tableViewManager = HomeTableViewManager()
  private var viewModel: HomeViewModelProtocol?
  
  // MARK: - Init
  
  public init(viewModel: HomeViewModelProtocol?) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - Lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()
    addViews()
    prepareNavigationBar()
    setHandlers()
    setupTableView()
    load()
    addRefreshControl()
  }
}

// MARK: - Private

private extension HomeController {
  
  func load() {
    Task { [weak self] in
      self?.dummyLoad()
      try await self?.loadContent()
    }
  }
  
  func loadContent() async throws {
    guard let presentation = try await viewModel?.load() else { return }
    tableViewManager.setPresentation(presentation)
    tableViewManager.setLoading(false)
    reloadData()
  }
  
  func dummyLoad() {
    tableViewManager.setLoading(true)
    if let dummyPresentation = viewModel?.dummyPresentation() {
      tableViewManager.setPresentation(dummyPresentation)
    }
    reloadData()
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func setHandlers() {
    tableViewManager.navigationVisibilityHandler = { visible in
      self.setNavigationBarAppearance(visible: visible)
    }
  }
  
  func addViews() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.leading.trailing.top.bottom.equalToSuperview()
    }
  }
  
  func setupTableView() {
    tableView.registerCell(HomeHeaderCell.self)
    tableView.registerCell(MediaListCell.self)
    tableView.dataSource = tableViewManager
    tableView.delegate = tableViewManager
  }
  
  func prepareNavigationBar() {
    let lefTImage = Resources.Image.icnNetflix
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: lefTImage)
    let rightImage = Resources.Image.icnSearch.withTintColor(.white)
    let rightBarButtonItem = UIBarButtonItem(image: rightImage)
    rightBarButtonItem.tintColor = .white
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  func setNavigationBarAppearance(visible: Bool) {
    UIView.animate(withDuration: 0.15) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      let alpha = visible ? 1 : 0.1
      appearance.backgroundColor = .black.withAlphaComponent(alpha)
      self.navigationController?.navigationBar.standardAppearance = appearance
      self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
      self.navigationController?.navigationBar.barTintColor = .black.withAlphaComponent(alpha)
      self.navigationController?.navigationBar.layoutIfNeeded()
    }
  }
}

// MARK: - PullToRefresh

extension HomeController {
  
  func addRefreshControl() {
    refreshControl.attributedTitle = NSAttributedString(
      string: "Updating!",
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold),
        NSAttributedString.Key.foregroundColor: UIColor.white
      ]
    )
    refreshControl.bounds = .init(
      x: refreshControl.bounds.origin.x,
      y: -80,
      width: refreshControl.bounds.size.width,
      height: refreshControl.bounds.size.height
    )
    tableView.refreshControl = refreshControl
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(onContentRefreshed), for: .valueChanged)
  }
  
  @objc func onContentRefreshed() {
    refreshContent()
    load()
  }
  
  func refreshContent() {
    DispatchQueue.main.async {
      self.refreshControl.endRefreshing()
    }
  }
}
