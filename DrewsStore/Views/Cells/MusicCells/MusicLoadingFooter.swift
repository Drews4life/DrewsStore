//
//  MusicLoadingFooter.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 4/2/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .darkGray
        indicator.startAnimating()
        
        let messageLbl = UILabel(text: "Loading additional music...", font: .systemFont(ofSize: 16))
        messageLbl.textAlignment = .center
        
        let stack = VerticalStackView(arrangedSubviews: [
            indicator,
            messageLbl
        ], spacing: 8)
        
        addSubview(stack)
        stack.centerInSuperview(size: CGSize(width: 200, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
