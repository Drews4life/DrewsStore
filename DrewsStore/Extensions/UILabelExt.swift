//
//  UILabelExt.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 14)) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
