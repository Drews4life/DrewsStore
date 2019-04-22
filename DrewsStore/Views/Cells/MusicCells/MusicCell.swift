//
//  MusicCell.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 4/2/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    var result: Result? {
        didSet {
            guard let result = result else { return }
            imageView.sd_setImage(with: URL(string: result.artworkUrl100))
            trackNameLbl.text = result.trackName
            subtitleLbl.text = "\(result.artistName ?? "") • \(result.collectionName ?? "")"
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let img = UIImageView(cornerRadius: 16)
        img.image = #imageLiteral(resourceName: "garden")
        img.constrainWidth(constant: 80)
        
        return img
    }()
    
    fileprivate let trackNameLbl: UILabel = {
        let lbl = UILabel(text: "track name", font: .boldSystemFont(ofSize: 16))
        
        return lbl
    }()
    
    fileprivate let subtitleLbl: UILabel = {
        let lbl = UILabel(text: "subtitle label", font: .systemFont(ofSize: 16))
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                trackNameLbl,
                subtitleLbl
            ], spacing: 0)
        ])
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
