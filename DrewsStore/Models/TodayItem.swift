//
//  TodayItem.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let description: String
    let image: UIImage
    let backgroundColor: UIColor
    let cellType: CellType
    let applications: [FeedResult]
    
    enum CellType: String {
        case single = "today_cell"
        case multiple = "today_multiple_app_cell"
    }
}
