//
//  HomeController.swift
//  YouTubeHomeFeed
//
//  Created by Vamshi Krishna on 06/05/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//  Source: https://www.letsbuildthatapp.com

import UIKit

private let reuseIdentifier = "Cell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos:[Video]?

    func fetchVideos(){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dictionary in json as! [[String:AnyObject]]{
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbNailImage = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    let channelDictionary = dictionary["channel"] as! [String:AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImage = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    self.videos?.append(video)
                }
                DispatchQueue.main.async(execute: {
                      self.collectionView?.reloadData()
                })
              
            } catch let jsonError{
                print(jsonError)
            }
        })
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        
        let titleLabel = UILabel(frame:Utility.shared.CGRectMake(0, 0, view.frame.width-32, view.frame.height))
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        navigationItem.titleView = titleLabel
        
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupNavBarButtons()
        setupMenuBar()
    }

    func setupNavBarButtons(){
        let searchImage = UIImage(named: "subscriptions")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let menuBarButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [searchBarButton, menuBarButton]
    }
    
    func handleMore(){
        
    }
    func handleSearch(){
       
    }
    
    let menuBar:MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: menuBar)
        
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        return Utility.shared.CGSizeMake(view.frame.width, height+88)
    }
    
    
}


