//
//  TodayViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var startingFrame: CGRect?
    var applicationFullScreenController: ApplicationFullscreenViewController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    private let items = [
        TodayItem(category: "SHARE YOUR THOUGHTS", title: "CHASE YOUR DREAMS", description: "All you need to accomplish your dream is chasing it. You will never be happy without a dream", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white),
        TodayItem(category: "GIVE IT A TRY", title: "NEW MMORPG OUT", description: "Accept a challenge to fight most powerfull heroes of the past in our new game!", image: #imageLiteral(resourceName: "holiday"), backgroundColor: #colorLiteral(red: 0.9893129468, green: 0.9681989551, blue: 0.7294917703, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9569426179, green: 0.94890064, blue: 0.9569777846, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TODAY_CELL)
//        collectionView.contentInset =
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let applicationFullscreenVC = ApplicationFullscreenViewController()
        applicationFullscreenVC.todayItem = items[indexPath.row]
        applicationFullscreenVC.didDismiss = { [weak self] in
            self?.dismissDetail()
        }
        
        let childView = applicationFullscreenVC.view ?? UIView()
        
        childView.layer.cornerRadius = 16
        childView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissDetail)))
        self.view.addSubview(childView)
        
        addChild(applicationFullscreenVC)
        self.applicationFullScreenController = applicationFullscreenVC
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TodayCell else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = childView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = childView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = childView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach{ $0?.isActive = true }
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)

        }, completion: nil)
    }
    
    @objc private func dismissDetail() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.applicationFullScreenController.tableView.contentOffset = .zero
            
            if let startingFrame = self.startingFrame {
                self.topConstraint?.constant = startingFrame.origin.y
                self.leadingConstraint?.constant = startingFrame.origin.x
                self.widthConstraint?.constant = startingFrame.width
                self.heightConstraint?.constant = startingFrame.height
                
                self.view.layoutIfNeeded()
            }
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }) { _ in
            self.applicationFullScreenController.view?.removeFromSuperview()
            self.applicationFullScreenController.removeFromParent()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TODAY_CELL, for: indexPath) as? TodayCell else { return TodayCell() }
        
        cell.todayItem = items[indexPath.row]
        
        return cell
    }
}
