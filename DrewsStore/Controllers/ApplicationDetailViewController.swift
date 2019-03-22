//
//  ApplicationDetailViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/22/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var applicationId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(applicationId ?? "")"
            
            APINetworking.shared.fetchJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
                if let err = error {
                    debugPrint("Unable to fetch specified application with error: \(err.localizedDescription)")
                    return
                }
                
                guard let result = searchResult?.results.first else { return }
                
                DispatchQueue.main.async {
                    self.setupUI(withResult: result)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationDetailCell.self, forCellWithReuseIdentifier: APP_DETAIL_CELL)
    }
    
    private func setupUI(withResult result: Result) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_DETAIL_CELL, for: indexPath) as? ApplicationDetailCell else { return ApplicationDetailCell() }
        
        
        return cell
    }
}
