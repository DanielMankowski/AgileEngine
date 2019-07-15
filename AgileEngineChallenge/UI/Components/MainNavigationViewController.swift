//
//  MainNavigationViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let nibIdentifier = String(describing: type(of: self))
        if let _ = Bundle.main.path(forResource: nibIdentifier, ofType: "nib") {
            super.init(nibName: nibIdentifier, bundle: nil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
        setup()
    }
    
    private func setup() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Colors.primary
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
