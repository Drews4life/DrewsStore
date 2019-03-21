//
//  SearchAppCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/19/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class SearchAppCell: UICollectionViewCell {
    
    var result: Result? {
        didSet {
            guard let result = result else { return }
            
            self.nameLbl.text = result.trackName
            self.categoryLbl.text = result.primaryGenreName
            self.ratingsLbl.text = "Rating: \(result.averageUserRating ?? 0)"
            
            self.appImageView.sd_setImage(with: URL(string: result.artworkUrl100), completed: nil)
            self.screenshotFirstImageView.sd_setImage(with: URL(string: result.screenshotUrls[0]))
            
            if result.screenshotUrls.count > 1 {
                self.screenshotSecondImageView.sd_setImage(with: URL(string: result.screenshotUrls[1]))
            }
            
            if result.screenshotUrls.count > 2 {
                self.screenshotThirdImageView.sd_setImage(with: URL(string: result.screenshotUrls[2]))
            }
        }
    }
    
    let appImageView: UIImageView = {
        let img = UIImageView(cornerRadius: 12)
        img.widthAnchor.constraint(equalToConstant: 64).isActive = true
        img.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        return img
    }()
    
    let nameLbl: UILabel = {
        let lbl = UILabel(text: "APP NAME")
        return lbl
    }()
    
    let categoryLbl: UILabel = {
        let lbl = UILabel(text: "Photos/Video")
        return lbl
    }()
    
    let ratingsLbl: UILabel = {
        let lbl = UILabel(text: "8.33M")
        return lbl
    }()
    
    let getAppBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        
        return btn
    }()
    
    lazy var screenshotFirstImageView = self.createScreenshotImageViews()
    lazy var screenshotSecondImageView = self.createScreenshotImageViews()
    lazy var screenshotThirdImageView = self.createScreenshotImageViews()
    
    private func createScreenshotImageViews() -> UIImageView {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 8
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 0.5
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        return img
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAllStackViews()
    }
    
    private func setupAllStackViews() {
        let labelStack = VerticalStackView(arrangedSubviews: [
            nameLbl,
            categoryLbl,
            ratingsLbl
        ])
        
        let appInfoTopStack = UIStackView(arrangedSubviews: [
            appImageView,
            labelStack,
            getAppBtn
        ])
        appInfoTopStack.spacing = 10
        appInfoTopStack.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [
            screenshotFirstImageView,
            screenshotSecondImageView,
            screenshotThirdImageView
        ]);
        screenshotsStackView.spacing = 6
        screenshotsStackView.distribution = .fillEqually
        
        let containerStackView = VerticalStackView(arrangedSubviews: [
            appInfoTopStack,
            screenshotsStackView
        ], spacing: 16)
        
        addSubview(containerStackView)
        containerStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
