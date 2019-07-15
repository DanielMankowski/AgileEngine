//
//  ParameterEncoder.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 15/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    func encode(request: inout URLRequest, with parameters: Parameters) throws
}
