//
//  MapViewController.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SDWebImage

class MapViewController: UIViewController, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var user: User!
    var titleLabel: UILabel!
    var imageView: UIImageView!
    let distanceSpan: Double = 2000
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        self.title = "Your Friend"
        let cellSize:CGFloat = 64
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = cellSize * 0.5
        imageView.layer.masksToBounds = true
        self.view.addSubview(imageView)
        
        
        
        
        titleLabel = UILabel()
        titleLabel.text = self.user.name
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        titleLabel.center = self.view.center
        
        self.view.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: cellSize).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: cellSize).isActive = true;
        let margins = view.layoutMarginsGuide
        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let url = URL(string: self.user.picture)

        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: .continueInBackground, progress: nil, completed: {(image:UIImage?, data:Data?, error:Error?, finished:Bool) in
            if image != nil {
                SDWebImageManager.shared().saveImage(toCache: image, for: url)
                self.imageView.image = image
            } else {
                SDWebImageManager.shared().imageCache?.queryCacheOperation(forKey: url?.absoluteString, done: { (image, data, type) in
                    self.imageView.image = image
                })
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView = MKMapView()

        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat =  view.frame.size.height * 0.5

        self.mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)

        self.mapView.mapType = MKMapType.standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        // Or, if needed, we can position map in the center of the view

        self.view.addSubview(self.mapView)

        if let mapView = self.mapView {
            let region = MKCoordinateRegion.init(center: user.location.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true

            let annotation = MKPointAnnotation()
            annotation.title = user.name
            annotation.coordinate = user.location.coordinate
            mapView.addAnnotation(annotation)
        }



        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: imageView.topAnchor).isActive = true

       
    }
    func safeSetRegion(_ region: MKCoordinateRegion) {
        let myRegion = self.mapView.regionThatFits(region)
        if !(myRegion.span.latitudeDelta.isNaN || myRegion.span.longitudeDelta.isNaN) {
            self.mapView.setRegion(myRegion, animated: true)
        }
    }
}
