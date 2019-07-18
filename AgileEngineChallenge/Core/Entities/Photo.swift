//
//  Photo.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class Photo {
    let id: String
    let title: String
    let imageUrl: String?
    let camera: String?
    
    init(id:String, title:String, imageUrl: String?, camera: String? = nil) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.camera = camera
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
