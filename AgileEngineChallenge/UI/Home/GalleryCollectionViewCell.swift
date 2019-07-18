//
//  GalleryCollectionViewCell.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setup(urlImage: String) {
        activityIndicator.startAnimating()
        imageView.sd_setImage(with: URL(string: urlImage)) { (image, _, _, _) in
            self.activityIndicator.stopAnimating()
        }
    }

}
