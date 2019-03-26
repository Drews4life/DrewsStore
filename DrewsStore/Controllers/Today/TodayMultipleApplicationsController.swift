//
//  TodayMultipleApplicationsController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/26/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayMultipleApplicationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var results = [FeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(MultipleApplicationCell.self, forCellWithReuseIdentifier: MULTIPLE_APP_CELL)
        
        fetchData()
    }
    
    private func fetchData() {
        APINetworking.shared.fetchGames { (applicationGroup, error) in
            if let _ = error {
                return
            }
            
            guard let appGroup = applicationGroup else { return }
            self.results = appGroup.feed.results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 64)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count > 4 ? 4 : results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MULTIPLE_APP_CELL, for: indexPath) as? MultipleApplicationCell else { return MultipleApplicationCell() }
        
        cell.result = results[indexPath.row]
        
        return cell
    }
}
