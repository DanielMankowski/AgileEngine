//
//  PhotosMock.swift
//  AgileEngineChallengeTests
//
//  Created by OLX - Daniel on 18/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

@testable import AgileEngineChallenge

public class PhotosMock: PhotosRepository {
    
    private var photos: [Photo] = []
    
    public init(withPhotos photos: [Photo]) {
        self.photos = photos
    }
    
    public func getRecentPhotos(page: Int, completion: @escaping ([Photo]) -> ()) {
        completion([Photo]())
    }
    
    public func searchPhotos(text: String, completion: @escaping ([Photo]) -> ()) {
        let foundPhotos = photos.filter({ (photo) -> Bool in
            return photo.title.contains(text)
        })
        completion(foundPhotos)
    }
    
    
}
