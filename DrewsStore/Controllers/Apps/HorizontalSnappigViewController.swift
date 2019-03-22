//
//  HorizontalSnappigViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/22/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class HorizontalSnappingViewController: UICollectionViewController {
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SnappingLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
     
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            let itemWidth = Float(layoutAttributes.frame.width)
            let direction: Float = velocity.x > 0 ? 1 : -1
           
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) + itemWidth * direction {
                offsetAdjustment = itemOffset - horizontalOffset
            }

        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
