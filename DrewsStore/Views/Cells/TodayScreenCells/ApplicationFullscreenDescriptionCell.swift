//
//  ApplicationFullscreenDescriptionCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationFullscreenDescriptionCell: UITableViewCell {
    
    let descriptionLbl: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "\nSome really astonishing games!", attributes: [
            .foregroundColor: UIColor.black
        ])
        attributedText.append(NSAttributedString(string: "  We know that you want to play this game already, huh?", attributes: [.foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "\n\nHere we go again with new Book!", attributes: [
            .foregroundColor: UIColor.black
        ]))
        attributedText.append(NSAttributedString(string: "  I really suggest you reading this book, its amazing!", attributes: [.foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "\n\nJust a placeholder!", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "  You really should not take things in life too seriously, sometimes the only thing you need in life is just a lemon", attributes: [.foregroundColor: UIColor.gray]))
        
        lbl.attributedText = attributedText
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLbl)
        descriptionLbl.fillSuperview(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
