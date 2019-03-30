//
//  TodayMultipleApplicationsController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/26/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayMultipleApplicationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    enum Mode: String {
        case small
        case fullscreen
    }
    
    var results = [FeedResult]()
    private let mode: Mode!
    
    private let closeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        return btn
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MultipleApplicationCell.self, forCellWithReuseIdentifier: MULTIPLE_APP_CELL)
        
        
        if mode == .fullscreen {
            setCloseBtn()
            navigationController?.isNavigationBarHidden = true
        } else {
            collectionView.isScrollEnabled = false
        }
    }
    
    private func setCloseBtn() {
        view.addSubview(closeBtn)
        closeBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 8), size: CGSize(width: 44, height: 44))
    }
    
    
    @objc private func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return UIEdgeInsets(top: 70, left: 24, bottom: 12, right: 24)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if mode == .fullscreen {
            return CGSize(width: view.frame.width - 48, height: 64)
        }
        
        return CGSize(width: view.frame.width, height: 64)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if results.count > 4 {
            if mode == .fullscreen {
                return results.count
            } else {
                return 4
            }
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        
        let applicationDetailVC = ApplicationDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        applicationDetailVC.applicationId = item.id
        
        navigationController?.pushViewController(applicationDetailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MULTIPLE_APP_CELL, for: indexPath) as? MultipleApplicationCell else { return MultipleApplicationCell() }
        
        cell.result = results[indexPath.row]
        
        return cell
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
