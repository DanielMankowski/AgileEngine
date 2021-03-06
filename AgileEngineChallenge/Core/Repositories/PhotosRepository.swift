//
//  PhotosRepository.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol PhotosRepository {
    func getRecentPhotos(page: Int, completion: @escaping ([Photo]) -> ())
    func searchPhotos(text: String, completion: @escaping ([Photo]) -> ())
}
