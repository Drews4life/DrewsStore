//
//  ApplicationFullscreenViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationFullscreenViewController: UITableViewController {
    
    var didDismiss: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    @objc private func dismissView(button: UIButton) {
        button.isHidden = true
        didDismiss?()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = ApplicationFullscreenHeaderCell()
            cell.todayCell.todayItem = todayItem
            cell.closeBtn.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
            
            return cell
        }
        
        let cell = ApplicationFullscreenDescriptionCell()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
