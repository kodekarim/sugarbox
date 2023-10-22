//
//  MainTabViewController.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
}

extension MainTabViewController  {
    func setupViewControllers() {
        setupHomeTab()
        setupMoviesTab()
        setupShowsTab()
    }
    
    func setupHomeTab() {
        if let homeTabViewController: HomeTabViewController = HomeTabViewController.viewController() {
            let navigationController = UINavigationController(rootViewController: homeTabViewController)
            navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
            self.addChild(navigationController)
        }
    }
    
    func setupMoviesTab() {
        if let movieTabViewController: MoviesTabViewController = MoviesTabViewController.viewController() {
            let navigationController = UINavigationController(rootViewController: movieTabViewController)
            navigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieclapper.fill"))
            self.addChild(navigationController)
        }
    }
    
    func setupShowsTab() {
        if let showTabViewController: ShowsTabViewController = ShowsTabViewController.viewController() {
            let navigationController = UINavigationController(rootViewController: showTabViewController)
            navigationController.tabBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "camera.macro.circle"), selectedImage: UIImage(systemName: "camera.macro.circle.fill"))
            self.addChild(navigationController)
        }
    }
}

extension MainTabViewController : ViewFromNib {}
