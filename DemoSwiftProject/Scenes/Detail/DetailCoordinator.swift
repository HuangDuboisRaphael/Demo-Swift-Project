//
//  DetailCoordinator.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 05/04/2024.
//

import UIKit

final class DetailCoordinator: ChildCoordinator {
    var navigationController: UINavigationController
    weak var parent: HomeCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var detailViewController: DetailViewController = {
        let viewController = DetailViewController()
        viewController.coordinator = self
        return viewController
    }()
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        popViewController(animated: true)
    }
        
    func start() {
        pushViewController(detailViewController, animated: true)
    }
}
