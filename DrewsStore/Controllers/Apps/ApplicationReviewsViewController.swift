//
//  ApplicationReviewsViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationReviewsViewController: HorizontalSnappingViewController, UICollectionViewDelegateFlowLayout {
    
    var reviews: Reviews? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationSingleReviewCell.self, forCellWithReuseIdentifier: APP_REVIEW_CELL)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_REVIEW_CELL, for: indexPath) as? ApplicationSingleReviewCell else { return ApplicationSingleReviewCell() }
        
        if let reviewEntry = reviews?.feed.entry[indexPath.item] {
            cell.review = reviewEntry
        }
        
        return cell
    }
}
