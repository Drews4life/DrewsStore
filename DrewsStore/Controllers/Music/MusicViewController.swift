//
//  MusicViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 4/2/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class MusicViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var results = [Result]()
    fileprivate var page = 0
    fileprivate var isPending = false
    fileprivate var isDonePaginating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MusicCell.self, forCellWithReuseIdentifier: MUSIC_CELL)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MUSIC_FOOTER)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        isPending = true
        APINetworking.shared.fetchMusicPaginated(page: page) { (searchResult, error) in
            if let _ = error {
                return
            }
            
            guard let fetchedResults = searchResult?.results else { return }
            
            sleep(2)
            if fetchedResults.count == 0 {
                self.isDonePaginating = true
            }
            
            self.isPending = false
            self.page += 1
            self.results += fetchedResults
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MUSIC_FOOTER, for: indexPath) as? MusicLoadingFooter else { return MusicLoadingFooter() }
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = isDonePaginating ? 0 : 100
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MUSIC_CELL, for: indexPath) as? MusicCell   else { return MusicCell() }
        
        cell.result = results[indexPath.item]
            
        if indexPath.item == results.count - 1 && !isPending {
            fetchData()
        }
        
        
        return cell
    }
}
