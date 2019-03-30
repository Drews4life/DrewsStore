//
//  ApplicationsViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var allGroups = [ApplicationGroup]()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = .black
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ApplicationsGroupCell.self, forCellWithReuseIdentifier: APP_GROUP_CELL)
        collectionView.register(ApplicationsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: APP_HEADER_VIEW)
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXInSuperview()
        activityIndicator.centerYInSuperview()
    
        fetchData()
    }
    
    private func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APINetworking.shared.fetchNewGames { (applicationGroup, error) in
            dispatchGroup.leave()
            if let _ = error {
                return
            }
            
            guard let group = applicationGroup else { return }
            self.allGroups.append(group)
        }
        
        dispatchGroup.enter()
        APINetworking.shared.fetchNewGames { (applicationGroup, error) in
            dispatchGroup.leave()
            if let _ = error {
                return
            }
            
            guard let group = applicationGroup else { return }
            self.allGroups.append(group)
        }
        
        dispatchGroup.enter()
        APINetworking.shared.fetchTopPaid { (applicationGroup, error) in
            dispatchGroup.leave()
            if let _ = error {
                return
            }
            
            guard let group = applicationGroup else { return }
            self.allGroups.append(group)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    private func getHeaderResourcesPlaceholder() -> [HeaderResult] {
        let firstResult = HeaderResult(name: "InstaWorld", title: "Share photos and get friends!", image: #imageLiteral(resourceName: "imgGirl"))
        let secondResult = HeaderResult(name: "SnapWorld", title: "Don't waste your life scrolling photos!", image: #imageLiteral(resourceName: "imgGirl2"))
        let thirdResult = HeaderResult(name: "CuriousWorld", title: "Find new friends!", image: #imageLiteral(resourceName: "imgGirl3"))
        
        return [firstResult, secondResult, thirdResult]
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: APP_HEADER_VIEW, for: indexPath) as? ApplicationsHeader else { return ApplicationsHeader() }
        
        header.headerHorizontalListController.headerResult = getHeaderResourcesPlaceholder()
        header.headerHorizontalListController.collectionView.reloadData()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APP_GROUP_CELL, for: indexPath) as? ApplicationsGroupCell else { return ApplicationsGroupCell() }
        
        let groupForCell = allGroups[indexPath.item]
        cell.titleLabel.text = groupForCell.feed.title
        cell.horizontalListController.applicationGroup = groupForCell
        cell.horizontalListController.collectionView.reloadData()
        
        cell.horizontalListController.didSelectHandler = { [weak self] chosenApplication in
            let applicationDetailsVC = ApplicationDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
            applicationDetailsVC.applicationId = chosenApplication.id
            
            self?.navigationController?.pushViewController(applicationDetailsVC, animated: true)
        }
        
        return cell
    }
}
