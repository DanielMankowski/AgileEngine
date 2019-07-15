//
//  PhotoDetailCoordinator.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class PhotoDetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController?
    private var viewController: PhotoDetailViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        viewController = PhotoDetailViewController()
        guard let viewController = viewController else { return }
        presenter?.pushViewController(viewController, animated: true)
    }
}
