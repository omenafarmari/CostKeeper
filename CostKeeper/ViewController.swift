//
//  ViewController.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/28/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit
import Realm
import Alamofire

class ViewController: UIViewController {


    @IBOutlet weak var tfShoppingItemPrice: UITextField!
    @IBOutlet weak var tfShoppingItemCategory: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var lblUsedThisMonth: UILabel!
    @IBOutlet weak var lblBudgetThisMonth: UILabel!
    @IBOutlet weak var tvResults: UITextView!
    
    let ShoppingDAO = ShoppingItemDAO()
    let budgetDAO = BudgetDAO()
    
    let ShoppingNetwork = ShoppingItemNetwork()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
 
    }

    override func viewDidLoad() {
        
        /*
        var image = UIImage(named: "DSC.png")
        var backgroundView2 = UIImageView(image: image)
      
        backgroundView2.sizeToFit()
        backgroundView2.image = image
        
        self.view.insertSubview(backgroundView2, atIndex: 0)*/

        var serverBudgets = [Budget]()
        var serverShoppingItems = [ShoppingItem]()
        
        Alamofire.request(.GET, "http://localhost:9080/budgets/")
            .responseJSON { (_, _, JSON, _) in
                
                if(JSON != nil) {
                
               var budgetsArr = (JSON as [NSDictionary])
                
                for budget in budgetsArr {
                    let newBudget = Budget()
                
                    newBudget.year = (budget["year"] as NSString).integerValue
                    newBudget.month = (budget["month"] as NSString).integerValue
                    newBudget.budgetId = (budget["globalId"] as NSString)
                    newBudget.budget = (budget["budget"] as NSString).doubleValue

                    serverBudgets.append(newBudget)

                }
                
                self.printBudgets(serverBudgets)
                }
                
        }
        

        Alamofire.request(.GET, "http://localhost:9080/shoppingitems/")
            .responseJSON { (_, _, JSON, _) in
                
                if (JSON != nil) {
        
                let shoppings = (JSON as [NSDictionary])
               
                for shopping in shoppings {
                    let newShopping = ShoppingItem()
            
                    newShopping.shoppingItemId = (shopping["globalId"] as NSString)
                    newShopping.price = (shopping["price"] as Double)
                    newShopping.name = (shopping["name"] as NSString)
                    newShopping.date = (shopping["date"] as NSDate)
                    newShopping.category = (shopping["category"] as NSString)
                    newShopping.store = (shopping["store"] as NSString)
                    
                    serverShoppingItems.append(newShopping)

                }
                
                self.printShoppings(serverShoppingItems)
                }
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var budgets = budgetDAO.getBudgets()
        print(budgets)
        
        fetchShoppingItems()
        
        var df = NSDateFormatter()
        
        var date = NSDate()
 
        let timestamp = date.timeIntervalSince1970
        var date2 = NSDate(timeIntervalSince1970: timestamp)
        var date3 =  NSDateFormatter.localizedStringFromDate(date2, dateStyle: .LongStyle, timeStyle: .ShortStyle)

        
        print(date3)
        
        
        df.dateFormat = "dd.MM.YYYY HH:mm"
        var currentMoment = df.stringFromDate(date)
        print(currentMoment)
        
        getThisMonthTotal()
        //lblBudgetThisMonth.text = String(format:"%d", )
        
        
    }
    
    func getThisMonthTotal() {
        
        let number = ShoppingDAO.getCurrentMonthShoppingItemTotal()
        
        print(number)
        //lblBudgetThisMonth.text = number.stringValue
        lblUsedThisMonth.text = number.stringValue
    }
    
    func printBudgets(budgets: [Budget]) {
        
        print(" count is from callback \(budgets.count)")
        
        for serverBudget in budgets {
            print("\(serverBudget.year) \(serverBudget.month)  \(serverBudget.budget)")
        }
    }
    
    func printShoppings(shoppings: [ShoppingItem]) {
        
        print("count is from callback \(shoppings.count)")
        
        for shoppingItem in shoppings {
            print("\(shoppingItem.shoppingItemId) \(shoppingItem.price) \(shoppingItem.name) \(shoppingItem.date) \(shoppingItem.category)")
        }
        
    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
                startBrowseShopingItems()
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
                startBudgetViewController()
            default:
                break
            }
        }
    }
    
    func startBudgetViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("budgetBrowse") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func startBrowseShopingItems() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("shoppingBrowse") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

     func fetchShoppingItems() {
        
        tvResults.text=""
        
        let shoppingItems = ShoppingDAO.fetchShoppingItems()
        
        for shoppingItem in shoppingItems {
            tvResults.text = "\(tvResults.text) \((shoppingItem.price as NSNumber).stringValue) € \(NSDateFormatter.localizedStringFromDate(shoppingItem.date, dateStyle: .MediumStyle, timeStyle: .ShortStyle))  \(shoppingItem.store)  \(shoppingItem.category) \n"
            
        }
        
    }

    @IBAction func saveShoppingItem(sender: AnyObject) {
        
        let newDate = NSDate()
        let item = ShoppingItem()
        item.shoppingItemId = NSUUID().UUIDString
        item.price = (tfShoppingItemPrice.text as NSString).doubleValue
        item.category = tfShoppingItemCategory.text

         item.date = newDate
        
        ShoppingDAO.saveShoppingItem(item)
        
        ShoppingNetwork.uploadToServer(item)
        
        tfShoppingItemCategory.resignFirstResponder()
        
        tfShoppingItemCategory.text = ""
        tfShoppingItemPrice.text = ""
        
        
        fetchShoppingItems()
        getThisMonthTotal()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

