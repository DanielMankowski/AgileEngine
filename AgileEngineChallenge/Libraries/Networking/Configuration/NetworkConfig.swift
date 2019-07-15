//
//  NetworkConfig.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public class NetworkConfig: NetworkConfigurator {
    
    public static let shared = NetworkConfig()
    
    private var headers: HTTPHeaders = [:]
    
    private init() {}
    
    init(withHeaders headers: HTTPHeaders) {
        self.headers = headers
    }
}

// MARK: - NetworkConfigurator related Methods
public extension NetworkConfig {
    func setDefaultHeaders(_ headers: HTTPHeaders) {
        self.headers = headers
    }
    
    func appendHeaders(_ headers: HTTPHeaders) {
        self.headers.merge(dict: headers)
    }
    
    func getHeaders() -> HTTPHeaders {
        return headers
    }
}
