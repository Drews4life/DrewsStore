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
        
        attributedText.append(NSAttributedString(string: "\n\nIt also takes a bit of a time here", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "  Either way it could not be possible, huh? I guess you find it someway creepy? But I dont think so. Anyways, do not waste your time going through a bunch of generic test I have on my mind, just because it makes no sense", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\nHowever-However-However", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "  Even though it makes no sense I feel a little bit happier while writing this, so thank you for going this far, unless you just scrolled to the end and reading this part without a single understanding of whats going on there.:)", attributes: [.foregroundColor: UIColor.gray]))
        
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
