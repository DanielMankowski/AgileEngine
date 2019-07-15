//
//  Endpoint.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var body: Parameters? { get }
    var query: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension Endpoint {
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}
