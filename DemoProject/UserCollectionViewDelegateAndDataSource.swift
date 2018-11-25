//
//  UserCollectionViewDelegateAndDataSource.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


public protocol MainviewControllerDelegate{
    @available(iOS 6.0, *)
    func didSelectItem(_ user:User)
}

class UserCollectionViewDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var data: Array<User> = []
    
    var delegate: MainviewControllerDelegate?
    
    override init() {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! UserCollectionViewCell
        cell.label.text = String(data[indexPath.row].name)
        let url = URL(string: data[indexPath.row].picture)
        
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: .continueInBackground, progress: nil, completed: {(image:UIImage?, data:Data?, error:Error?, finished:Bool) in
            if image != nil {
                SDWebImageManager.shared().saveImage(toCache: image, for: url)
                cell.imageView.image = image
            } else {
                SDWebImageManager.shared().imageCache?.queryCacheOperation(forKey: url?.absoluteString, done: { (image, data, type) in
                    cell.imageView.image = image
                })
            }
        })
        // TODO
        return cell
    }
    
}
