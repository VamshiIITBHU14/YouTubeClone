//
//  MenuBar.swift
//  YouTubeHomeFeed
//
//  Created by Vamshi Krishna on 07/05/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class MenuBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.returnRGBColor(r: 230, g: 32, b: 32, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let reuseIdentifier = "Cell"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.returnRGBColor(r: 91, g: 14, b: 13, alpha: 1)
        collectionView.selectItem(at: IndexPath(item:0, section:0), animated: false, scrollPosition:[])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Utility.shared.CGSizeMake(frame.width/4, frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell:BaseCell{
    
    var imageView:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.returnRGBColor(r: 91, g: 14, b: 13, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor.returnRGBColor(r: 91, g: 14, b: 13, alpha: 1)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
