//
//  ViewController.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MainviewControllerDelegate {
    
    var headerView: UIView!
    var titleLabel: UILabel!
    var userCollectionView: UICollectionView!
    let userCollectionViewDelegateAndDataSource = UserCollectionViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLabel()
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 64);
        userCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        userCollectionView.backgroundColor = .lightGray
        userCollectionViewDelegateAndDataSource.delegate = self


        self.view.addSubview(userCollectionView)

        API.getUser(success: { (response) in
           self.parseData(response)

        }) { (error, cachedJson) in
            self.parseData(cachedJson)
            print(error)
        }
        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        userCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        userCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        userCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        userCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    

        userCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        userCollectionView.delegate = userCollectionViewDelegateAndDataSource
        userCollectionView.dataSource = userCollectionViewDelegateAndDataSource
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func parseData(_ json: Any) {
        let array: [[String: Any]] = json as! [[String: Any]]
        var users: Array<User> = []
        for item in array {
            print("item-------------------------------")
            print(type(of: item))
            print(item)
            users.append(User(dictionary: item))
        }
        self.userCollectionViewDelegateAndDataSource.data = users
        self.userCollectionView.reloadData()
    }
    
    func didSelectItem(_ user: User) {
        let mapViewController = MapViewController();
        mapViewController.user = user
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        self.title = "All Friends"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = userCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.height - view.safeAreaInsets.top
            layout.itemSize = CGSize(width: width, height: 64)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = userCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.height
            layout.itemSize = CGSize(width: width, height: 64)
            layout.invalidateLayout()
        }
    }
    
    
}

