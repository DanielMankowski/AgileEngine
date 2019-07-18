//
//  Infrastructure.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 17/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class Infrastructure {
    static let shared = Infrastructure()
    private init() {}
    
    private lazy var photos: PhotosRepository = {
        return Photos(flickrProvider: FlickrClient(), photoCreator: PhotosFactory())
    }()
    
    func photosRepository() -> PhotosRepository {
        return photos
    }
}
