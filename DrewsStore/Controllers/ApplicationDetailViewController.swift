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
                self.application = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(applicationId ?? "")/sortby=mostrecent/json?l=en&&cc=us"
            
            APINetworking.shared.fetchJSONData(urlString: reviewsUrl) { (result: Reviews?, error) in
                if let _ = error {
                    return
                }
                
                guard let result = result else { return }
               
                self.reviews = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var application: Result?
    var reviews: Reviews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationDetailCell.self, forCellWithReuseIdentifier: APP_DETAIL_CELL)
        collectionView.register(ApplicationPreviewCell.self, forCellWithReuseIdentifier: APP_PREVIEW_CELL)
        collectionView.register(ApplicationReviewRowCell.self, forCellWithReuseIdentifier: APP_REVIEW_ROW_CELL)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let dummyCell = ApplicationDetailCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.application = application
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
            
            return CGSize(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 500)
        } else if indexPath.item == 2 && reviews?.feed.entry.count == nil {
            return CGSize(width: view.frame.width, height: 0)
        }
        
        return CGSize(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_DETAIL_CELL, for: indexPath) as? ApplicationDetailCell else { return ApplicationDetailCell() }
            
            cell.application = application
            
            return cell
        } else if indexPath.item ==  1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_PREVIEW_CELL, for: indexPath) as? ApplicationPreviewCell else { return ApplicationPreviewCell() }
            
            cell.horizontalPreviewController.application = application
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_REVIEW_ROW_CELL, for: indexPath) as? ApplicationReviewRowCell else { return ApplicationReviewRowCell() }
            
            cell.reviewsHorizontalViewController.reviews = reviews
            
            return cell
        }
    }
}
