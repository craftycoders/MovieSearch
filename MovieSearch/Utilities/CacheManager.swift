//
//  CacheManager.swift
//  MovieSearch
//
//  Created by Lyle Jover on 8/14/21.
//

import Foundation
import UIKit
class ImageCache {
    //MARK: Properties
    static let shared = ImageCache()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {
        //Limits to 100 objects in cache. If reached, it will start unloading.
        cache.countLimit = 100
    }
    
    //MARK: Public methods
    func save(image: UIImage, for key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    func getImage(for key: NSString) -> UIImage? {
        return cache.object(forKey: key) as UIImage?
    }
    
}
