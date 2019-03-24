//
//  PreviewScreenshotCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/24/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class PreviewScreenshotCell: UICollectionViewCell {
    
    let screenImageView: UIImageView = {
        let img = UIImageView(cornerRadius: 12)
        img.backgroundColor = .lightGray
        
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(screenImageView)
        screenImageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
