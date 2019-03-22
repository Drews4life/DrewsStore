//
//  ViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/19/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var appResults = [Result]()
    private var timer: Timer?
    private let searchBarController = UISearchController(searchResultsController: nil)
    
    private let enterSearchTermLbl: UILabel = {
        let lbl = UILabel(text: "Search for an app!", font: .boldSystemFont(ofSize: 18))
        lbl.textAlignment = .center
        lbl.textColor = .darkGray
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchAppCell.self, forCellWithReuseIdentifier: SEARCH_APP_CELL)
        
        collectionView.addSubview(enterSearchTermLbl)
        enterSearchTermLbl.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        
        setupSearchBar()
    }
    
    private func setupSearchBar () {
        definesPresentationContext = true
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            APINetworking.shared.fetchItunesApps(searchTerm: searchText) { (searchResults, error) in
                if let _ = error {
                    return
                }
                
                guard let results = searchResults?.results else { return }
                self.appResults = results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        enterSearchTermLbl.isHidden = appResults.count > 0
        
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SEARCH_APP_CELL, for: indexPath) as? SearchAppCell else { return SearchAppCell() }
        
        cell.result = appResults[indexPath.item]
        
        return cell
    }
    
}

