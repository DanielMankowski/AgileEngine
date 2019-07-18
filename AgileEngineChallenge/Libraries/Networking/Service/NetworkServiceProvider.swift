//
//  NetworkServiceProvider.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public class NetworkServiceProvider: NSObject, NetworkService {
    
    /// Shared session for all the NetworkServiceProvider created
    private static let sharedSession = URLSession.shared
    
    public var session: URLSession
    
    private var task: URLSessionTask?
    private let endpoint: Endpoint
    private let config: NetworkConfigurator
    
    public init(endpoint: Endpoint, urlSession: URLSession? = nil, networkConfigurator: NetworkConfigurator = NetworkConfig.shared) {
        if let urlSession = urlSession {
            self.session = urlSession
        } else {
            self.session = NetworkServiceProvider.sharedSession
        }
        
        self.config = networkConfigurator
        self.endpoint = endpoint
    }
    
    public func doRequest(completion: @escaping NetworkCompletion) {
        do {
            let request = try buildRequest(from: endpoint)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
}

// MARK: - Helper methods
extension NetworkServiceProvider {
    
    fileprivate func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                 cachePolicy: endpoint.cachePolicy,
                                 timeoutInterval: 10.0)
        
        addHeaders(fromEndpoint: endpoint, request: &request)
        
        request.httpMethod = endpoint.httpMethod.rawValue
        do {
            try configureParameters(bodyParameters: endpoint.body,
                                    encoding: endpoint.encoding,
                                    urlParameters: endpoint.query,
                                    request: &request)
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         encoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try encoding.encode(urlRequest: &request, body: bodyParameters, query: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addHeaders(fromEndpoint endpoint: Endpoint, request: inout URLRequest) {
        var headers = config.getHeaders()
        
        if let extraHeaders = endpoint.headers {
            headers.merge(dict: extraHeaders)
        }
        
        request.allHTTPHeaderFields = headers
    }
    
}
