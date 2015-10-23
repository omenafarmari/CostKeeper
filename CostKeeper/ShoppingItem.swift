//
//  ShoppingItem.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/28/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Realm

class ShoppingItem: RLMObject {
    dynamic var shoppingItemId = "0"
    dynamic var price = 0.00
    dynamic var name = "item"
    dynamic var date = NSDate()
    dynamic var category = "unknown"
    dynamic var store = "store"
    
}