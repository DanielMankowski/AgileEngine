//
//  ParameterEncoding.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public enum ParameterEncoding {
    case url
    case json
    case clean
    
    public func encode(urlRequest: inout URLRequest, body: Parameters? = nil, query: Parameters? = nil) throws {
        do {
            switch self {
            case .url:
                guard let urlParameters = query else { return }
                try URLParameterEncoder().encode(request: &urlRequest, with: urlParameters)
            case .json:
                guard let bodyParameters = body else { return }
                try JSONParameterEncoder().encode(request: &urlRequest, with: bodyParameters)
            case .clean:
                guard let urlParameters = query else { return }
                try CleanParameterEncoder().encode(request: &urlRequest, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
