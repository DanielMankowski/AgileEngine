//
//  GalleryListCoordinator.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class GalleryListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var viewController: GalleryListViewController?
    private var photoDetailCoordinator: PhotoDetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        viewController = GalleryListViewController()
        guard let viewController = viewController else { return }
        viewController.delegate = self
        presenter.setViewControllers([viewController], animated: false)
    }
}

extension GalleryListCoordinator: GalleryListViewControllerDelegate {
    func galleryListDidSelectPhoto(photos: [Photo], selectedPhoto: Int) {
        photoDetailCoordinator = PhotoDetailCoordinator(presenter: presenter, photos: photos, currentPhoto: selectedPhoto)
        photoDetailCoordinator?.start()
    }
}
