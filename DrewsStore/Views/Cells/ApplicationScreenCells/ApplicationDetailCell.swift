//
//  ApplicationDetailCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/22/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationDetailCell: UICollectionViewCell {
    
    var application: Result? {
        didSet {
            guard let application = application else { return }
            guard let iconUrl = URL(string: application.artworkUrl100) else { return }
            
            applicationIconImageView.sd_setImage(with: iconUrl)
            nameLbl.text = application.trackName
            releaseNotesLbl.text = application.releaseNotes
            //latestUpdatesLbl.text = application.
            
            if let price = application.formattedPrice {
                priceButton.setTitle(price, for: .normal)
            }
        }
    }
    
    fileprivate let applicationIconImageView: UIImageView = {
        let img = UIImageView(cornerRadius: 12)
        img.constrainWidth(constant: 140)
        img.constrainHeight(constant: 140)
        
        return img
    }()
    
    fileprivate let nameLbl: UILabel = {
        let lbl = UILabel(text: "App name", font: .boldSystemFont(ofSize: 18))
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    fileprivate let priceButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("0.99$", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.08411604911, green: 0.4194744825, blue: 0.9397012591, alpha: 1)
        btn.constrainHeight(constant: 32)
        btn.constrainWidth(constant: 80)
        btn.layer.cornerRadius = 32 / 2
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    fileprivate let latestUpdatesLbl: UILabel = {
        let lbl = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 19))
        
        return lbl
    }()
    
    fileprivate let releaseNotesLbl: UILabel = {
        let lbl = UILabel(text: "Release notes label", font: .systemFont(ofSize: 14))
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let infoSubStack = VerticalStackView(arrangedSubviews: [
            nameLbl,
            UIStackView(arrangedSubviews: [priceButton, UIView()]),
            UIView()
        ], spacing: 5)
        
        let horizontalStackOfAppInfo = UIStackView(arrangedSubviews: [
            applicationIconImageView,
            infoSubStack
        ])
        horizontalStackOfAppInfo.spacing = 10
        
        let stack = VerticalStackView(arrangedSubviews: [
            horizontalStackOfAppInfo,
            latestUpdatesLbl,
            releaseNotesLbl
        ], spacing: 15)
        
        addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
