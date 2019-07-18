//
//  Actions.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 17/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class Actions {
    static func getRecentPhotos() -> GetRecentPhotos {
        return GetRecentPhotos(photosRepository: Infrastructure.shared.photosRepository())
    }
    
    static func searchPhotos() -> SearchPhotos {
        return SearchPhotos(photosRepository: Infrastructure.shared.photosRepository())
    }
}
