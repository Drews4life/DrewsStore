//
//  ApplicationsPreviewViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationPreviewViewController: HorizontalSnappingViewController, UICollectionViewDelegateFlowLayout {
    
    var application: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PreviewScreenshotCell.self, forCellWithReuseIdentifier: APP_SCREENSHOT_CELL)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return application?.screenshotUrls?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_SCREENSHOT_CELL, for: indexPath) as? PreviewScreenshotCell else { return PreviewScreenshotCell() }
        
        if let urlString = application?.screenshotUrls?[indexPath.item] {
            if let url = URL(string: urlString) {
                cell.screenImageView.sd_setImage(with: url)
            }
        }
        
        return cell
    }
}
