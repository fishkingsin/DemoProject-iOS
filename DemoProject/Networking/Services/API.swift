//
//  API.swift
//  DemoProject
//
//  Created by James Kong on 25/11/2018.
//  Copyright © 2018 James Kong. All rights reserved.
//

import Foundation
import AFNetworking

class API {
    
    class func getUser(success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Error, _ cacheResponse: Any) -> Void) {
        
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        

        
        manager.get("http://www.json-generator.com/api/json/get/cfdlYqzrfS", parameters: nil, progress: { (Progress) in
            
        }, success: { (operation, responseObject) -> Void in
            
            do{
                let data:Data = try! JSONSerialization.data(withJSONObject: responseObject!, options: [] )
                let cachedResponse:CachedURLResponse = CachedURLResponse.init(response: operation.response!, data: data);
                // cache it
                URLCache.shared.storeCachedResponse(cachedResponse, for: operation.currentRequest!)
            }
            
            success(responseObject!)
        }, failure: { (operation, error) -> Void in
            let cachedResponse: CachedURLResponse = URLCache.shared.cachedResponse(for: operation!.currentRequest!)!

            print(cachedResponse.data)
            let data: Data = cachedResponse.data
            
            let cacheJson = try? JSONSerialization.jsonObject(with: data, options: [])

            failure(error, cacheJson!)
        })

    }

}
