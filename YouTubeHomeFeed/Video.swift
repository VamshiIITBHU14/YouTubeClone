//
//  Video.swift
//  YouTubeHomeFeed
//
//  Created by Vamshi Krishna on 07/05/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbNailImage:String?
    var title:String?
    var channel:Channel?
    var numberOfViews:NSNumber?
    var uploadDate:NSDate?
}

class Channel:NSObject{
    var name:String?
    var profileImage:String?
}
