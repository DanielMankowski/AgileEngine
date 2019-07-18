//
//  FlickrResponse.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class FlickrResponse: Codable {
    var photos: FlickrPagedResponse
    let stat: String
}

class FlickrPagedResponse: Codable {
    let photo: [FlickrPhoto]
    let page: Int
    let pages: Int
}
