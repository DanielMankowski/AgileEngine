//
//  SearchPhotos.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 18/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class SearchPhotos {
    
    private let repository: PhotosRepository
    
    init(photosRepository: PhotosRepository) {
        self.repository = photosRepository
    }
    
    func invoke(text: String, completion: @escaping (SearchPhotosResult) -> ()) {
        guard text.count > 2 else {
            completion(SearchPhotosResult.failure(error: .keywordLength))
            return
        }
        repository.searchPhotos(text: text, completion: { (photos) in
            if photos.count > 0 {
                completion(SearchPhotosResult.success(photos: photos))
            } else {
                completion(SearchPhotosResult.failure(error: .notFound))
            }
        })
    }
}

enum SearchPhotosResult: Equatable {
    case success(photos: [Photo])
    case failure(error: FailureType)
    
    static func == (lhs: SearchPhotosResult, rhs: SearchPhotosResult) -> Bool {
        switch (lhs, rhs) {
        case let (.success(photos: a), .success(photos: b)):
            return a == b
        case let (.failure(error: a), .failure(error: b)):
            return a == b
        default:
            return false
        }
    }
}
