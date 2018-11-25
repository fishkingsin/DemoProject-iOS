//
//  ViewController.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import UIKit
class MyUICollectionViewFlowLayout : UICollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        self.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 64);
        return true
    }
}
class MainViewController: UIViewController, MainviewControllerDelegate {

    var headerView: UIView!
    var titleLabel: UILabel!
    var userCollectionView: UICollectionView!
    let userCollectionViewDelegateAndDataSource = UserCollectionViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLabel()
        let frame = self.view.frame
        let layout = MyUICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 64);
        userCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        userCollectionView.backgroundColor = .lightGray
        userCollectionViewDelegateAndDataSource.delegate = self

        
        self.view.addSubview(userCollectionView)
        
        API.getUser(success: { (response) in
            let array: [[String: Any]] = response as! [[String: Any]]
            var users: Array<User> = []
            for item in array {
                print("item-------------------------------")
                print(type(of: item))
                print(item)
                users.append(User(dictionary: item))
            }
            self.userCollectionViewDelegateAndDataSource.data = users
            self.userCollectionView.reloadData()
            
        }) { (error) in
            print(error)
        }
        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        userCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        userCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        userCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        userCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        
        userCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        userCollectionView.delegate = userCollectionViewDelegateAndDataSource
        userCollectionView.dataSource = userCollectionViewDelegateAndDataSource
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didSelectItem(_ user: User) {
        let mapViewController = MapViewController();
        
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        headerView = UIView()
        headerView.backgroundColor = .white
        self.navigationController?.navigationBar.addSubview(headerView)
        
        titleLabel = UILabel()
        titleLabel.text = "All Friends"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        
        headerView.addSubview(titleLabel)
        
        // Set position of views using constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

