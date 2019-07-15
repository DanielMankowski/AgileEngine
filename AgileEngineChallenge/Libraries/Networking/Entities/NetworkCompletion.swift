//
//  NetworkCompletion.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
