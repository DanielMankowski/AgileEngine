//
//  HomeViewController.swift
//  AgileEngineChallenge
//
//  Created by Daniel Mankowski on 14/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var galleryList: GalleryListViewController!

    private struct Constants {
        static let searchPhotos = "Search Photos"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary
        setNavigation()
        setGalleryList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.searchController?.searchBar.HideHairlineView()
    }
    
    private func setNavigation() {
        navigationItem.searchController = searchController
        searchController.searchBar.setTextFieldColor(.red)
        searchController.searchBar.backgroundColor = Colors.primary
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.searchPhotos // it should be localized
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func setGalleryList() {
        galleryList = GalleryListViewController()
        addChild(galleryList)
        view.addSubview(galleryList.view)
        
        galleryList.view.translatesAutoresizingMaskIntoConstraints = false
        
        galleryList.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        galleryList.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        galleryList.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        galleryList.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchController.isActive = false
    }
}
