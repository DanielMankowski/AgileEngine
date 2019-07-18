//
//  GetRecentPhotosEndpoint.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class FlickrGetRecentPhotosEndpoint: FlickrBaseEndpoint {
    
    private var page: Int = 1
    
    init(withPage page: Int) {
        self.page = page
    }
    override var query: Parameters? {
        var parameters = Parameters()
        parameters["api_key"] = "0d84cd4abde0e2966df97dcd411ae05f"
        parameters["format"] = "json"
        parameters["nojsoncallback"] = "1"
        parameters["extras"] = "url_h"
        parameters["method"] = "flickr.photos.getRecent"
        parameters["page"] = page
        parameters["per_page"] = 40
        
        return parameters
    }
}
