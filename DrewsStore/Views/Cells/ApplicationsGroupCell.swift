//
//  ApplicationsGroupCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationsGroupCell: UICollectionViewCell {
    
    let horizontalListController = ApplicationsHorizontalViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let titleLabel: UILabel = {
        let lbl = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 25))
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalListController.view)
        horizontalListController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
