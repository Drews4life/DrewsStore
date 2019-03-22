//
//  ApplicationsHorizontalViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationsHorizontalViewController: HorizontalSnappingViewController, UICollectionViewDelegateFlowLayout {
    
     var applicationGroup: ApplicationGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationRowCell.self, forCellWithReuseIdentifier: IN_GROUP_APP_CELL)
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let topAndBottomPaddings: CGFloat = 24 // each 12
        let lineSpacings: CGFloat = 20 // two lines, each 10
        
        let height = (view.frame.height - topAndBottomPaddings - lineSpacings) / 3
        
        return CGSize(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return applicationGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IN_GROUP_APP_CELL, for: indexPath) as? ApplicationRowCell else { return ApplicationRowCell() }
        
        cell.result = applicationGroup?.feed.results[indexPath.item]
        
        return cell
    }
}
