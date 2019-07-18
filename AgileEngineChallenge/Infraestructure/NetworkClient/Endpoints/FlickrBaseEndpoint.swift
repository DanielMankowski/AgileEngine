//
//  FlickrBaseEndpoint.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class FlickrBaseEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://www.flickr.com/services/rest/")!
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: Parameters? {
        return nil
    }
    
    var query: Parameters? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return .url
    }
    
    
}
