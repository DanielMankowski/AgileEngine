//
//  FlickrProvider.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol FlickrProvider {
    func getRecentPhotos(page: Int, completion: @escaping (_ photos: [FlickrPhoto], _ error: Error?) -> ())
    func searchPhotos(text: String, completion: @escaping (_ photos: [FlickrPhoto], _ error: Error?) -> ())
}
