//
//  ApplicationsHeaderHorizontalViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/21/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit


class ApplicationsHeaderHorizontalViewController: HorizontalSnappingViewController, UICollectionViewDelegateFlowLayout {
    
    var headerResult = [HeaderResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationHeaderCell.self, forCellWithReuseIdentifier: APP_HEADER_CELL)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: view.frame.height)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_HEADER_CELL, for: indexPath) as? ApplicationHeaderCell else { return ApplicationHeaderCell() }
        
        cell.result = headerResult[indexPath.item]
        
        return cell
    }
}
