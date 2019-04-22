//
//  TodayViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class TodayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var startingFrame: CGRect?
    var applicationFullScreenController: ApplicationFullscreenViewController!
    var applicationFullscreenOffset: CGFloat = 0
    var anchoredConstraints: AnchoredConstraints?
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = .darkGray
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        return activity
    }()
    
    fileprivate let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    fileprivate var items = [TodayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurEffectView)
        blurEffectView.fillSuperview()
        blurEffectView.alpha = 0
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9569426179, green: 0.94890064, blue: 0.9569777846, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleApplicationCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchData() {
        let group = DispatchGroup()
        
        var topPaidGroup: ApplicationGroup?
        var newGames: ApplicationGroup?
        
        group.enter()
        APINetworking.shared.fetchTopPaid { (applicationGroup, error) in
            group.leave()
            if let _ = error {
                return
            }
            
            guard let appGroup = applicationGroup else { return }
            topPaidGroup = appGroup
            print(topPaidGroup?.feed.results[0])
        }
        
        group.enter()
        APINetworking.shared.fetchNewGames { (applicationGroup, error) in
            group.leave()
            if let _ = error {
                return
            }
            
            guard let appGroup = applicationGroup else { return }
            newGames = appGroup
        }
        
        group.notify(queue: .main) {
            
            self.items = [
                TodayItem(category: "SHARE YOUR THOUGHTS", title: "CHASE YOUR DREAMS", description: "All you need to accomplish your dream is chasing it. You will never be happy without a dream", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .single, applications: []),
                TodayItem(category: "WEEKLY LIST", title: topPaidGroup?.feed.title ?? "", description: "", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, applications: topPaidGroup?.feed.results ?? []),
                TodayItem(category: "GIVE IT A TRY", title: "NEW MMORPG OUT", description: "Accept a challenge to fight most powerfull heroes of the past in our new game!", image: #imageLiteral(resourceName: "holiday"), backgroundColor: #colorLiteral(red: 0.9893129468, green: 0.9681989551, blue: 0.7294917703, alpha: 1), cellType: .single, applications: []),
                TodayItem(category: "MONTHLY LIST", title: newGames?.feed.title ?? "", description: "", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, applications: newGames?.feed.results ?? [])
            ]
            
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
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
    
    fileprivate func showFullscreenDailyList(_ indexPath: IndexPath) {
        let fullscreenVC = TodayMultipleApplicationsController(mode: .fullscreen)
        fullscreenVC.results = items[indexPath.row].applications
        
        present(BackNavigationController(rootViewController: fullscreenVC), animated: true, completion: nil)
        
    }
    
    fileprivate func beginFullscreenVCAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurEffectView.alpha = 1
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.applicationFullScreenController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ApplicationFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullscreen(_ indexPath: IndexPath) {
        setupSingleFullscreenController(indexPath)
        setupSingleFullscreenControllersPosition(indexPath)
        beginFullscreenVCAnimation()
    }
    
    fileprivate func setupSingleFullscreenController(_ indexPath: IndexPath) {
        let applicationFullscreenVC = ApplicationFullscreenViewController()
        applicationFullscreenVC.todayItem = items[indexPath.row]
        applicationFullscreenVC.didDismiss = { [weak self] in
            self?.dismissDetail()
        }
        
        self.applicationFullScreenController = applicationFullscreenVC
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragging))
        gesture.delegate = self
        
        applicationFullscreenVC.view.addGestureRecognizer(gesture)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    fileprivate func setupSingleFullscreenControllersPosition(_ indexPath: IndexPath) {
        let singleFullscreenView = self.applicationFullScreenController.view ?? UIView()
    
        singleFullscreenView.layer.cornerRadius = 16
        singleFullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissDetail)))
        self.view.addSubview(singleFullscreenView)
    
        addChild(self.applicationFullScreenController)
        self.collectionView.isUserInteractionEnabled = false
    
        guard let cell = collectionView.cellForItem(at: indexPath) as? TodayCell else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    
        self.anchoredConstraints = singleFullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: CGSize(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    
    }
    
    @objc fileprivate func handleDragging(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began {
            applicationFullscreenOffset = self.applicationFullScreenController.tableView.contentOffset.y
        }
         
        if self.applicationFullScreenController.tableView.contentOffset.y > 0 {
            return
        }
        
        let translationY = gesture.translation(in: self.applicationFullScreenController.view).y
        
        if gesture.state == .changed {
            if translationY > 0 {
                let realOffset = translationY - applicationFullscreenOffset
                var scale = 1 - translationY / 1000
                
                scale = min(1, scale)
                scale = max(0.5, scale)
                
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                self.applicationFullScreenController.view.transform = transform
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
                dismissDetail()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.row].cellType == .multiple {
            showFullscreenDailyList(indexPath)
        } else {
            showSingleAppFullscreen(indexPath)
        }
    }
    
    @objc fileprivate func dismissDetail() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.applicationFullScreenController.smallPreviewView.alpha = 0
            self.applicationFullScreenController.tableView.contentOffset = .zero
            self.blurEffectView.alpha = 0
            self.applicationFullScreenController.view.transform = .identity
            
            if let startingFrame = self.startingFrame {
                self.anchoredConstraints?.top?.constant = startingFrame.origin.y
                self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
                self.anchoredConstraints?.height?.constant = startingFrame.height
                self.anchoredConstraints?.width?.constant = startingFrame.width
                
                self.view.layoutIfNeeded()
            }
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            
            guard let cell = self.applicationFullScreenController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ApplicationFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.closeBtn.alpha = 0
            cell.layoutIfNeeded()
            
        }) { _ in
            self.applicationFullScreenController.view?.removeFromSuperview()
            self.applicationFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellType.rawValue, for: indexPath) as? BaseTodayCell else { return UICollectionViewCell() }
        
        cell.todayItem = item
        
        (cell as? TodayMultipleApplicationCell)?.applicationCollectionController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        
        return cell
    }
    
    @objc fileprivate func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        var superview = collectionView?.superview
        
        while superview != nil {
            if let cell = superview as? TodayMultipleApplicationCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                showFullscreenDailyList(indexPath)
                return
            }
            
            superview = superview?.superview
        }
    }
}
