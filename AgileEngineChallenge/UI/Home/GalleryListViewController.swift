//
//  GalleryListViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class GalleryListViewController: BaseViewController {
    
    private var gallery: UICollectionView!
    
    private struct Constants {
        static let gridValue: CGFloat = 8.0
    }
    
    private var numberOfItems: CGFloat {
        if UIDevice.current.orientation.isPortrait {
            return 2
        } else { //Lanscape orientation
            return 3
        }
    }
    
    override init() {
        super.init()
        setupGallery()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
    }
    
    private func setupGallery() {
        gallery = UICollectionView(frame: view.frame, collectionViewLayout: getCollectionViewLayout())
        gallery.register(GalleryCollectionViewCell.nib, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
        gallery.backgroundColor = Colors.primary
        gallery.delegate = self
        gallery.dataSource = self
        gallery.contentInset = UIEdgeInsets(top: 0, left: Constants.gridValue, bottom: 0, right: Constants.gridValue)
        gallery.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gallery)
        gallery.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.gridValue).isActive = true
        
        gallery.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        gallery.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        gallery.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.gridValue).isActive = true
    }
    
    private func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.gridValue
        layout.minimumInteritemSpacing = Constants.gridValue * 2
        layout.scrollDirection = .vertical
        return layout
    }
}

extension GalleryListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell {
            cell.setup()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.frame.width / numberOfItems - 3 * Constants.gridValue
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.gridValue, left: Constants.gridValue, bottom: 0, right: Constants.gridValue)
    }
}
