//
//  AppDelegate.swift
//  DummyFlix
//
//  Created by Oguz Parlak on 28.11.2022.
//

import UIKit
import SkeletonView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = makeRoot()
    window?.makeKeyAndVisible()
    applyUIConfigurations()
    forceDarkMode()
    return true
  }
  
  private func makeRoot() -> UIViewController {
    let viewModel = HomeViewModel()
    let homeController = HomeController(viewModel: viewModel)
    let root = UINavigationController(rootViewController: homeController)
    return root
  }
  
  private func forceDarkMode() {
    window?.overrideUserInterfaceStyle = .dark
  }
  
  private func applyUIConfigurations() {
    SkeletonAppearance.default.skeletonCornerRadius = 8
    SkeletonAppearance.default.multilineCornerRadius = 8
  }
}
