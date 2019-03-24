//
//  ApplicationPreviewCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationPreviewCell: UICollectionViewCell {
    
    let horizontalPreviewController = ApplicationPreviewViewController()
    
    private let previewLbl: UILabel = {
        let lbl = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 22))
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        
        addSubview(separator)
        separator.constrainHeight(constant: 0.5)
        separator.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(previewLbl)
        previewLbl.anchor(top: separator.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        
        addSubview(horizontalPreviewController.view)
        horizontalPreviewController.view.anchor(top: previewLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
