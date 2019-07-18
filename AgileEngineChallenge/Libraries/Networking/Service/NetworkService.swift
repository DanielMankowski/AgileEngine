//
//  NetworkService.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol NetworkService {
    var session: URLSession { get }
    
    func doRequest(completion: @escaping NetworkCompletion)
    func cancel()
}
