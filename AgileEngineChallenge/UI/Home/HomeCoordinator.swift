//
//  GalleryListCoordinator.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var viewController: HomeViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        viewController = HomeViewController()
        guard let viewController = viewController else { return };
        presenter.setViewControllers([viewController], animated: false)
    }
}
