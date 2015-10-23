//
//  BudgetDAO.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/29/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Realm

class BudgetDAO: NSObject {
    
    func saveBudget (budget: Budget) {
        
          let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            realm.addObject(budget)
            realm.commitWriteTransaction()
    }
    
    func getBudgets() -> RLMResults {
        
        let budgets = Budget.allObjects()
        
        
        return budgets
        
    }
   
}
