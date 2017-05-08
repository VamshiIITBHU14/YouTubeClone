//
//  Extensions.swift
//  YouTubeHomeFeed
//
//  Created by Vamshi Krishna on 07/05/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

extension UIColor{
    static func returnRGBColor(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}

extension UIView{
    func addConstraintsWithFormat(format:String, views: UIView...){
        
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView{
    
    var imageURLString:String?
    func loadImageFromURLString(urlString:String){
           imageURLString = urlString
            let url = URL(string: urlString)
            image = nil
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
              self.image = imageFromCache
              return
            }
            let request = URLRequest(url: url!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    print(error!)
                    return
                }
                DispatchQueue.main.async(execute: {
                    let imageToCache = UIImage(data:data!)
                    if(self.imageURLString == urlString){
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    
                })
            })
            task.resume()
    }
}
