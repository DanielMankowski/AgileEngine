//
//  AppCoordinator.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let mainWindow: UIWindow
    private let homeCoordinator: GalleryListCoordinator
    private let rootViewController: UINavigationController
    
    init(withWindow window: UIWindow) {
        self.mainWindow = window
        rootViewController = MainNavigationViewController()
        homeCoordinator = GalleryListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        self.mainWindow.rootViewController = rootViewController
        homeCoordinator.start()
        self.mainWindow.makeKeyAndVisible()
    }
}
