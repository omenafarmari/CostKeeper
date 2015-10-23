//
//  Budget.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/29/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Realm

class Budget: RLMObject {
    dynamic var budgetId = "0"
    dynamic var month = 0
    dynamic var year = 2000
    dynamic var budget = 0.00

    
}