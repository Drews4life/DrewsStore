//
//  ApplicationFullscreenViewController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/25/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit

class ApplicationFullscreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var didDismiss: (() -> ())?
    var todayItem: TodayItem?
    
    let smallPreviewView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.layer.cornerRadius = 12
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.addSubview(blur)
        view.clipsToBounds = true
        blur.fillSuperview()
        
        return view
    }()
    
    var isPreviewHidden = true
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        
        if scrollView.contentOffset.y >= 160 && isPreviewHidden {
            animatePreview()
        } else if scrollView.contentOffset.y < 160 && !isPreviewHidden {
            animatePreview(hide: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 18
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        let height = UIApplication.shared.statusBarFrame.height
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        
        setupPreviewView()
    }
    
    fileprivate func setupPreviewView() {
        view.addSubview(smallPreviewView)
        
        let bottomPadding = UIApplication.shared.statusBarFrame.height
        
        smallPreviewView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: bottomPadding, right: 16), size: CGSize(width: 0, height: 85))
        self.smallPreviewView.transform = CGAffineTransform(translationX: 0, y: 120)
        
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem?.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.constrainWidth(constant: 60)
        imageView.constrainHeight(constant: 60)
        
        let titleLbl = UILabel(text: todayItem?.title ?? "", font: .boldSystemFont(ofSize: 12))
        let categoryLbl = UILabel(text: todayItem?.category ?? "", font: .systemFont(ofSize: 11))
        let getBtn = UIButton(type: .system)
        getBtn.setTitle("GET", for: .normal)
        getBtn.setTitleColor(.white, for: .normal)
        getBtn.backgroundColor = .darkGray
        getBtn.layer.cornerRadius = 12
        getBtn.constrainWidth(constant: 80)
        getBtn.constrainHeight(constant: 32)
        
        let titlesSubstack = VerticalStackView(arrangedSubviews: [
            titleLbl,
            categoryLbl
        ], spacing: 5)
        titlesSubstack.alignment = .center
        titlesSubstack.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                titleLbl,
                categoryLbl
                ], spacing: 5),
            getBtn
            ])
        stackView.spacing = 16
        
        smallPreviewView.addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
        
        smallPreviewView.alpha = 1
    }
    
    fileprivate func animatePreview(hide: Bool = false) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.smallPreviewView.transform = hide ? CGAffineTransform(translationX: 0, y: 120) : .identity
        }, completion: { _ in
            self.isPreviewHidden = hide
        })
    }
    
    @objc fileprivate func dismissView(button: UIButton) {
        button.isHidden = true
        didDismiss?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = ApplicationFullscreenHeaderCell()
            cell.todayCell.todayItem = todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.closeBtn.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
            
            return cell
        }
        
        let cell = ApplicationFullscreenDescriptionCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        
        return UITableView.automaticDimension
    }
}
