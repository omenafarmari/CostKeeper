//
//  InterfaceController.swift
//  CostKeeper WatchKit Extension
//
//  Created by Tuukka Tallgren on 3/17/15.
//  Copyright (c) 2015 Tuukka Tallgren. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        print("Opened")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
