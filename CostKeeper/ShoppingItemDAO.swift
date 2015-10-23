//
//  ShoppingItemDAO.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/28/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Realm

class ShoppingItemDAO: NSObject {
    
    func saveShoppingItem (item: ShoppingItem) {
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addObject(item)
        realm.commitWriteTransaction()
    
    }
    
    func deleteShoppingItem(shoppingItemId: ShoppingItem) {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.deleteObject(shoppingItemId as RLMObject)
        realm.commitWriteTransaction()
    }
    
    func getCurrentMonthShoppingItemTotal() -> NSNumber {
        
        // Setup the calendar object
        let calendar = NSCalendar.currentCalendar()
        
        // Set up date object
        let date = NSDate()
        
        // Create an NSDate for the first and last day of the month
        //let components = calendar.components(NSCalendarUnit.CalendarUnitYear |
        //                                     NSCalendarUnit.CalendarUnitMonth |
        //                                     NSCalendarUnit.WeekdayCalendarUnit |
        //                                     NSCalendarUnit.WeekCalendarUnit |
        //                                     NSCalendarUnit.CalendarUnitDay,
        //                                     fromDate: date)
        
        // Create an NSDate for the first and last day of the month
        let components = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: date)
        
        // Getting the First and Last date of the month
        components.day = 1
        let firstDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        components.month  += 1
        components.day     = 0
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        print(firstDateOfMonth)
        print(lastDateOfMonth)
        
        let predicate = NSPredicate(format: "date >= %@ && date <= %@", firstDateOfMonth, lastDateOfMonth)
        let currentMonthShoppings = ShoppingItem.objectsWithPredicate(predicate).sumOfProperty("price")
        
        return currentMonthShoppings
        
    }
    
    func fetchShoppingItems() -> [ShoppingItem] {
                
        let shoppingItemResults = ShoppingItem.allObjects().sortedResultsUsingProperty("date", ascending: false)
        var shoppingItems = [ShoppingItem]()
        

        
        for shoppingResult in shoppingItemResults {
            let shoppingItem = shoppingResult as ShoppingItem
            shoppingItems.append(shoppingItem)
        }
        
        return shoppingItems
        
    }
    

   
}
