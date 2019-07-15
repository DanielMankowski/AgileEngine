//
//  BaseViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    public init() {
        let nibIdentifier = String(describing: type(of: self))
        if let _ = Bundle.main.path(forResource: nibIdentifier, ofType: "nib") {
            super.init(nibName: nibIdentifier, bundle: nil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
