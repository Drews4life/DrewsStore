//
//  ApplicationSingleReviewCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationSingleReviewCell: UICollectionViewCell {
    
    var review: Entry? {
        didSet {
            guard let review = review else { return }
            titleLbl.text = review.title.label
            nameLbl.text = review.author.name.label
            bodyReviewLbl.text = review.content.label
            
            for (index, view) in ratingStarsStackView.arrangedSubviews.enumerated() {
                if let rateIng = Int(review.rating.label) {
                    view.alpha = index >= rateIng ? 0 : 1
                }
                
            }
        }
    }
    
    fileprivate let titleLbl: UILabel = {
        let lbl = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 17))
        
        return lbl
    }()
    
    fileprivate let nameLbl: UILabel = {
        let lbl = UILabel(text: "Name", font: .systemFont(ofSize: 14))
        
        return lbl
    }()

    fileprivate let bodyReviewLbl: UILabel = {
        let lbl = UILabel(text: "Body\nBody\nBody\n", font: .systemFont(ofSize: 18))
        lbl.numberOfLines = 4
        
        return lbl
    }()
    
    fileprivate let ratingStarsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        
        (0..<5).forEach({ _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainHeight(constant: 24)
            imageView.constrainWidth(constant: 24)
            
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2457726884)
        
        let lblStack = UIStackView(arrangedSubviews: [
            titleLbl,
            nameLbl
        ])
        lblStack.spacing = 8
        titleLbl.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        nameLbl.textAlignment = .right
        
        let mainStack = VerticalStackView(arrangedSubviews: [
            lblStack,
            ratingStarsStackView,
            bodyReviewLbl
        ], spacing: 12)
        
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 14, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
