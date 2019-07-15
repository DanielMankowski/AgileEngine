//
//  GalleryCollectionViewCell.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    func setup() {
        imageView.image = UIImage(named: "ShareThis")
    }

}
