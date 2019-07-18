//
//  Photos.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class Photos: PhotosRepository {
    
    private let flickr: FlickrProvider
    private let photoCreator: PhotoCreator
    
    init(flickrProvider: FlickrProvider,
         photoCreator: PhotoCreator) {
        self.flickr = flickrProvider
        self.photoCreator = photoCreator
    }
    
    func getRecentPhotos(page: Int, completion: @escaping ([Photo]) -> ()) {
        flickr.getRecentPhotos(page: page) { (flickrPhotos, error) in
            let photos = flickrPhotos
                .filter({ $0.url_h != nil })
                .map({
                self.photoCreator.createPhoto(fromFlickr: $0)
            })
            completion(photos)
        }
    }
    
    func searchPhotos(text: String, completion: @escaping ([Photo]) -> ()) {
        flickr.searchPhotos(text: text) { (flickrPhotos, error) in
            let photos = flickrPhotos
                .filter({ $0.url_h != nil })
                .map({
                    self.photoCreator.createPhoto(fromFlickr: $0)
                })
            completion(photos)
        }
    }
}
