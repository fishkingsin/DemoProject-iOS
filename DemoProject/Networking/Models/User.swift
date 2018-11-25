//
//  User.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import Foundation
import MapKit
public struct User {
    var _id : String
    var email : String
    var location : CLLocation!
    var name : String
    var picture : String
    init(dictionary: [String:Any]) {
        // set the Optional ones
        self._id = (dictionary["_id"] as? String)!
        self.email = (dictionary["email"] as? String)!
        
        // set the one with a default
//        var location: [String: NSNumber] = dictionary["location"] as? [String: NSNumber]
        let location = dictionary["location"] as! [String: Any]
        if let latitude = location["latitude"] as? Double, let longitude = location["longitude"] as? Double {
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        }
        self.name = (dictionary["name"] as? String)!
        self.picture = (dictionary["picture"] as? String)!
    }
}
