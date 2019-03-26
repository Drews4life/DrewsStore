//
//  TodayCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    override var todayItem: TodayItem? {
        didSet {
            guard let item = todayItem else { return }
            
            imageView.image = item.image
            backgroundColor = item.backgroundColor
            categoryLbl.text = item.category
            titleLbl.text = item.title
            descriptionLbl.text = item.description
        }
    }
    
    private let imageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "garden"))
        img.contentMode = .scaleAspectFill
        //img.clipsToBounds = true
        
        return img
    }()
    
    private let categoryLbl: UILabel = {
        let lbl = UILabel(text: "", font: .boldSystemFont(ofSize: 15))
        
        return lbl
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel(text: "", font: .boldSystemFont(ofSize: 22))
        
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel(text: "", font: .systemFont(ofSize: 13))
        lbl.numberOfLines = 3
        
        return lbl
    }()
    
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        backgroundColor = .white
        layer.cornerRadius = 18
        
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.centerInSuperview(size: CGSize(width: 200, height: 200))
        
        let titlesStack = VerticalStackView(arrangedSubviews: [
            categoryLbl,
            titleLbl,
            imageContainer,
            descriptionLbl
        ], spacing: 8)
        
        addSubview(titlesStack)
        
        titlesStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
        
        self.topConstraint = titlesStack.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
