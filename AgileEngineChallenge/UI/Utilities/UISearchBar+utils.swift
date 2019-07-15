//
//  UISearchBar+utils.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

extension UISearchBar {
    /// This method finds the textfield that we can see inside a SearchBar.
    ///
    /// - Returns: the textfield inside the SearchBar.
    func textField() -> UITextField? {
        var textField: UITextField?
        subviews.forEach { (view) in
            view.subviews.forEach({ (finalView) in
                if let finalView = finalView as? UITextField {
                    textField = finalView
                }
            })
        }
        return textField
    }
    
    /// Sets the color in the textfield that is inside the SearchBar.
    ///
    /// - Parameter color: the color to set.
    func setTextFieldColor(_ color: UIColor) {
        if let backgroundTextField = textField()?.subviews.first {
            backgroundTextField.backgroundColor = color
            backgroundTextField.layer.cornerRadius = 10
            backgroundTextField.clipsToBounds = true
        }
    }
    
    /// This methods hide the view that is below the search bar (to hide the one on the top of it
    /// The iteration done by `findHairlineView` should be done directly on NavigationBar.
    func HideHairlineView() {
        guard let searchControllerView = superview else { return }
        let image = findHairlineView(under: searchControllerView)
        image?.isHidden = true
    }
    
    /// On SearchBarControllers embedded in Navigation Bars, there's a hairline view that is
    /// actually a view to add a shadow image.
    /// However, this view is difficult to find in simple ways. To do it, this method iterates over
    /// subviews of the container. This function is recursive, so use it wisely.
    ///
    /// - Parameter view: the base view where we should start to iterate.
    /// - Returns: the hairline view.
    func findHairlineView(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findHairlineView(under: subview) {
                return imageView
            }
        }
        return nil
    }
}
