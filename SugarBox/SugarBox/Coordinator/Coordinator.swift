//
//  Coordinator.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator : [Coordinator] { get }
    var navigationController : UINavigationController { get }
    
    func start()
}

class MainCoordinator : Coordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func start() {
        let initialViewController = HomeTabViewController()
        initialViewController.mainCoordinator = self
        initialViewController.viewModel = HomeViewModel(apiService: APIService())
        initialViewController.navigationItem.title = HOME_TITLE
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(initialViewController, animated: false)
    }
    
    func moveToDetails(data:Contents) {
        let detailViewController = DetailViewController()
        detailViewController.viewModel = DetailViewModel(content: data)
        detailViewController.navigationItem.title = data.title?.uppercased()
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(detailViewController, animated: false)
    }
    
}
