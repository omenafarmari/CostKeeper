//
//  ShoppingItemNetwork.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 24/12/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Alamofire

class ShoppingItemNetwork: NSObject {
    
    var URL: NSString = "http://localhost:9080/"
    //var URL: NSString = "http://koodiklubi.fi:9080/"
    
    func uploadToServer(shopping: ShoppingItem) {
        
        let parameters :  [ String : AnyObject] = [
            "id": "",
            "globalId": shopping.shoppingItemId,
            "price": shopping.price,
            "store": shopping.store,
            "name": shopping.name,
            "category": shopping.category,
            "date": shopping.date
            
        ]
        
        //Alamofire.request(.POST, "\(URL)shoppingitems/add", parameters: parameters, encoding: .JSON)
    }

   
}
