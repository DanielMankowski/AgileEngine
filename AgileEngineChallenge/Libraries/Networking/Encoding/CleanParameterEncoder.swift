//
//  CleanParameterEncoder.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

class CleanParameterEncoder: ParameterEncoder {
    func encode(request: inout URLRequest, with parameters: Parameters) throws {
        guard let url = request.url else { throw NSError(domain: "NetworkError", code: 1000, userInfo: nil) }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
        
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
