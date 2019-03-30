//
//  BackNavigationController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/27/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class BackNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
