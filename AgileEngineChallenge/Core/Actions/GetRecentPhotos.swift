//
//  GetRecentPhotos.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class GetRecentPhotos {
    
    private let repository: PhotosRepository
    
    init(photosRepository: PhotosRepository) {
        self.repository = photosRepository
    }
    
    func invoke(page: Int, completion: @escaping (GetRecentPhotosResult) -> ()) {
        repository.getRecentPhotos(page: page, completion: { (photos) in
            if photos.count > 0 {
                completion(GetRecentPhotosResult.success(photos: photos))
            } else {
                completion(GetRecentPhotosResult.failure(error: .notFound))
            }
        })
    }
}

enum GetRecentPhotosResult: Equatable {
    case success(photos: [Photo])
    case failure(error: FailureType)
    
    static func == (lhs: GetRecentPhotosResult, rhs: GetRecentPhotosResult) -> Bool {
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

enum FailureType: String {
    case notFound
    case keywordLength
}
