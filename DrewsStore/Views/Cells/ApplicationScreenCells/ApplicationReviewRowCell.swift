//
//  ApplicationReviewRowCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit


class ApplicationReviewRowCell: UICollectionViewCell {
    
    let reviewsHorizontalViewController = ApplicationReviewsViewController()
    
    private let reviewsAndRatingsLbl: UILabel = {
        let lbl = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 22))
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsAndRatingsLbl)
        reviewsAndRatingsLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        
        addSubview(reviewsHorizontalViewController.view)
        reviewsHorizontalViewController.view.anchor(top: reviewsAndRatingsLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
