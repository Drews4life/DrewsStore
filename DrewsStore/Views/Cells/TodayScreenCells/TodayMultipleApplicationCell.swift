//
//  TodayMultipleApplicationCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/26/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayMultipleApplicationCell: BaseTodayCell {
    
    override var todayItem: TodayItem? {
        didSet {
            guard let item = todayItem else { return }
            
            categoryLbl.text = item.category
            titleLbl.text = item.title
            backgroundColor = item.backgroundColor
        }
    }
    
    private let categoryLbl: UILabel = {
        let lbl = UILabel(text: "", font: .boldSystemFont(ofSize: 18))
        
        return lbl
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel(text: "", font: .boldSystemFont(ofSize: 22))
        lbl.numberOfLines = 3
        
        return lbl
    }()
    
    let applicationCollectionController = TodayMultipleApplicationsController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 18
        
        let stack = VerticalStackView(arrangedSubviews: [
            categoryLbl,
            titleLbl,
            applicationCollectionController.view
        ], spacing: 12)
        
        addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
