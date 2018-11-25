//
//  UserCollectionViewCell.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import Foundation
import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        let cellSize = contentView.bounds.size.height
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cellSize * 0.5
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        label = UILabel(frame: contentView.frame)
        contentView.addSubview(label)
        label.textAlignment = .left
        label.font = UIFont(name: label.font.fontName, size: 12)
        self.contentView.backgroundColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)    
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        
        
        
        
        
    }
}
