//
//  NetworkConfigurator.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol NetworkConfigurator {
    func setDefaultHeaders(_ headers: HTTPHeaders)
    func appendHeaders(_ headers: HTTPHeaders)
    func getHeaders() -> HTTPHeaders
}
