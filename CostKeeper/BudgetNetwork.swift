//
//  BudgetNetwork.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 12/20/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Alamofire

class BudgetNetwork: NSObject {
    
    var URL: NSString = "http://localhost:9080/"
    //var URL: NSString = "http://koodiklubi.fi:9080/"
    
    func uploadToServer(budget: Budget) {
    
        print("uploading to server")
        let parameters :  [ String : AnyObject] = [

            "globalId": budget.budgetId,
            "year": budget.year,
            "month": budget.month,
            "budget": budget.budget
            
        ]
        
        Alamofire.request(.POST, "\(URL)budgets/add", parameters: parameters, encoding: .JSON)
    }
    
    
   
}
