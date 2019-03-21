//
//  UIImageViewExt.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/21/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = .lightGray
    }
}
