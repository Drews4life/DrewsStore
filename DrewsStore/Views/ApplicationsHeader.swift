//
//  ApplicationsHeader.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/21/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationsHeader: UICollectionReusableView {
    
    private let headerHorizontalListController = ApplicationsHeaderHorizontalViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerHorizontalListController.view)
        headerHorizontalListController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
