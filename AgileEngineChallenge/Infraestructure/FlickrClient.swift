//
//  FlickrClient.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class FlickrClient: FlickrProvider {
    private var pages: Int = 99999
    func getRecentPhotos(page: Int, completion: @escaping ([FlickrPhoto], Error?) -> ()) {
        guard page <= pages else {
            completion([FlickrPhoto](), nil)
            return
        }
        NetworkServiceProvider(endpoint: FlickrGetRecentPhotosEndpoint(withPage: page)).doRequest { (data, response, error) in
            do {
                if let unwrapedData = data {
                    let flickrResponse = try JSONDecoder().decode(FlickrResponse.self, from: unwrapedData)
                    self.pages = flickrResponse.photos.pages
                    completion(flickrResponse.photos.photo, nil)
                }
            }
            catch let err {
                print("The catch: \(err)")
                print("Actual error: \(String(describing: error))")
            }
        }
    }
    
    func searchPhotos(text: String, completion: @escaping ([FlickrPhoto], Error?) -> ()) {
        NetworkServiceProvider(endpoint: FlickrSearchPhotosEndpoint(withText: text)).doRequest { (data, response, error) in
            do {
                if let unwrapedData = data {
                    let flickrResponse = try JSONDecoder().decode(FlickrResponse.self, from: unwrapedData)
                    self.pages = flickrResponse.photos.pages
                    completion(flickrResponse.photos.photo, nil)
                }
            }
            catch let err {
                print("The catch: \(err)")
                print("Actual error: \(String(describing: error))")
            }
        }
    }
}
