//
//  GalleryListViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

protocol GalleryListViewControllerDelegate: class {
    func galleryListDidSelectPhoto(photos: [Photo], selectedPhoto: Int)
}

class GalleryListViewController: BaseViewController {
    
    private var searchViewController: UISearchController = UISearchController(searchResultsController: nil)
    private var gallery: UICollectionView!
    private var photos: [Photo] = [Photo]()
    private var currentPage: Int = 1
    
    weak var delegate: GalleryListViewControllerDelegate?
    
    private struct Constants {
        static let gridValue: CGFloat = 8.0
        static let threshold: Int = 10
        static let searchShows = "Search Shows" //Should be localized
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
        setupSearchBar()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecentPhotos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.searchController?.searchBar.HideHairlineView()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
    }
    
    private func setupSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchViewController
        searchViewController.searchBar.backgroundColor = Colors.primary
        searchViewController.hidesNavigationBarDuringPresentation = false
        searchViewController.searchBar.setTextFieldColor(.white)
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.placeholder = Constants.searchShows
        searchViewController.searchBar.delegate = self
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
    
    private func getRecentPhotos() {
        let getRecentPhotos = Actions.getRecentPhotos()
        getRecentPhotos.invoke(page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            if case let GetRecentPhotosResult.success(photos) = result {
                self.photos.append(contentsOf: photos)
                self.gallery.reloadData()
            } else {
                //TODO: Call Alert with error
            }
        }
    }
    
    private func checkIfNeedToLoadMorePhotos(index: Int) {
        guard photos.count - index <= Constants.threshold else { return }
        currentPage += 1
        getRecentPhotos()
    }
}

extension GalleryListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        checkIfNeedToLoadMorePhotos(index: indexPath.row)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell {
            let photo = photos[indexPath.row]
            guard let imageUrl = photo.imageUrl else { return UICollectionViewCell() }
            cell.setup(urlImage: imageUrl)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.galleryListDidSelectPhoto(photos: photos, selectedPhoto: indexPath.row)
    }
}

extension GalleryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension GalleryListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchViewController.isActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchPhotos = Actions.searchPhotos()
        guard let text = searchBar.text else { return }
        searchPhotos.invoke(text: text) { [weak self] (result) in
            guard let self = self else { return }
            if case let SearchPhotosResult.success(photos) = result {
                self.photos = photos
                self.gallery.reloadData()
            } else {
                //Show alert, search need at least 3 characters
                self.photos.removeAll()
                self.getRecentPhotos()
            }
        }
    }
}
