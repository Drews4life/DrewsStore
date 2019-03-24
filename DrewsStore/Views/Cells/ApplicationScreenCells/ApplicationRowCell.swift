//
//  ApplicationRowCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/21/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit
import SDWebImage

class ApplicationRowCell: UICollectionViewCell {
    
    var result: FeedResult? {
        didSet {
            guard let result = result else { return }
            companyNameLbl.text = result.artistName
            appNameLbl.text = result.name
            appIconImageView.sd_setImage(with: URL(string: result.artworkUrl100))
        }
    }
    
    private let appIconImageView: UIImageView = {
        let img = UIImageView(cornerRadius: 12)
        img.constrainWidth(constant: 64)
        img.constrainHeight(constant: 64)
        
        return img
    }()
    
    private let appNameLbl: UILabel = {
        let lbl = UILabel(text: "App name", font: .systemFont(ofSize: 19))
        
        return lbl
    }()
    
    private let companyNameLbl: UILabel = {
        let lbl = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
        
        return lbl
    }()
    
    private let getAppBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("GET", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.constrainWidth(constant: 80)
        btn.constrainHeight(constant: 32)
        btn.layer.cornerRadius = 32 / 2
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let labelStackView = VerticalStackView(arrangedSubviews: [
            appNameLbl,
            companyNameLbl
        ])
        labelStackView.axis = .vertical
        
        let mainStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            labelStackView,
            getAppBtn
        ])
        
        addSubview(mainStackView)
        mainStackView.alignment = .center
        mainStackView.spacing = 16
        mainStackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
