//
//  PhotosFactory.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol PhotoCreator {
    func createPhoto(fromFlickr flickrPhoto: FlickrPhoto) -> Photo
}

class PhotosFactory: PhotoCreator {
    func createPhoto(fromFlickr flickrPhoto: FlickrPhoto) -> Photo {
        return Photo(id: flickrPhoto.id, title: flickrPhoto.title, imageUrl: flickrPhoto.url_h)
    }
}
