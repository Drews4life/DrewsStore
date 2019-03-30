//
//  BaseTodayCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/26/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    var todayItem: TodayItem!
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            }, completion: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = UIView()
        addSubview(self.backgroundView!)
        self.backgroundView?.fillSuperview()
        
        backgroundView?.layer.cornerRadius = 16
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.shadowOpacity = 0.25
        backgroundView?.layer.shadowRadius = 10
        backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView?.layer.shouldRasterize = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
