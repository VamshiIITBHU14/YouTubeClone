//
//  VideoCell.swift
//  YouTubeHomeFeed
//
//  Created by Vamshi Krishna on 07/05/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell:BaseCell{
    
    var video :Video?{
        didSet{
            titleLabel.text = video?.title
            setupThumbNailImage()
            setupProfileImage()
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            if let channelName = video?.channel?.name, let numberOfViewsAfterFormatting = numberFormatter.string(from: (video?.numberOfViews)!){
                subTitleView.text = "\(channelName) : \(numberOfViewsAfterFormatting)" + "\n" + "2 Years ago"
            }
            
            //measuringTitleLabelTextHeight
            if let title = video?.title{
                let size = Utility.shared.CGSizeMake(frame.width - 16 - 8 - 44 - 16 , 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)], context: nil)
                
                if estimatedRect.size.height > 20{
                    titleLabelHeightConstraint?.constant = 44
                }
                else{
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupProfileImage(){
        if let profileImageURL = video?.channel?.profileImage{
            userProfileImageView.loadImageFromURLString(urlString: profileImageURL)
        }
    }
    
    func setupThumbNailImage(){
        if let thumbNailImageURL = video?.thumbNailImage{
            self.thumbnailImageView.loadImageFromURLString(urlString: thumbNailImageURL)
        }
    }
    let thumbnailImageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var titleLabelHeightConstraint:NSLayoutConstraint?
    
    override func setUpViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
