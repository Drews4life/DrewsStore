//
//  ApplicationHeaderCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/21/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationHeaderCell: UICollectionViewCell {
    
    var result: HeaderResult? {
        didSet {
            guard let result = result else { return }
            companyLbl.text = result.name
            titleLbl.text = result.title
            frontImageView.image = result.image
        }
    }
    
    private let companyLbl: UILabel = {
        let lbl = UILabel(text: "Company", font: .boldSystemFont(ofSize: 12))
        lbl.textColor = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 1)
        
        return lbl
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel(text: "Placeholder title, life is great!", font: .systemFont(ofSize: 18))
//        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 12
        
        return lbl
    }()
    
    private let frontImageView: UIImageView = {
        let img = UIImageView(cornerRadius: 8)
//        img.constrainWidth(constant: 64)
//        img.constrainHeight(constant: 200)
        
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStack = VerticalStackView(arrangedSubviews: [
            companyLbl,
            titleLbl,
            frontImageView
        ], spacing: 12)
        
        addSubview(verticalStack)
        verticalStack.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
