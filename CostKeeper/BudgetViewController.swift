//
//  BudgetViewController.swift
//  CostKeeper
//
//  Created by Tuukka Tallgren on 11/29/14.
//  Copyright (c) 2014 Tuukka Tallgren. All rights reserved.
//

import UIKit


class BudgetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tfBudget: UITextField!
    @IBOutlet weak var tfMonth: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tffd: UITextField!
    
    var months = [String]()
    var years = [String]()
    var budgetDAO = BudgetDAO()
    var budgetNetwork = BudgetNetwork()
    
    @IBAction func tfMonthEnded(sender: AnyObject) {
        
        self.picker.hidden = true
        
    }
    @IBAction func tfMonthEdited(sender: AnyObject) {
        
    self.picker.hidden = false
      
        self.picker.backgroundColor = UIColor.grayColor()
        
        self.tfMonth.text = "\(months[picker.selectedRowInComponent(0)]) / \(years[picker.selectedRowInComponent(1)])"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        var df = NSDateFormatter()
        
        for var i = 0; i<12; i++ {
            
            let monthName: AnyObject! = df.monthSymbols[i]
            months.insert(monthName as! String, atIndex: i)
            
        }
        
        for var i = 2010; i<2100;i++ {
            
            var year = String(i)
            years.append(year)
        }
        
        var date = NSDate()
        df.dateFormat = "M"
        
        
        var month: Int! = Int(df.stringFromDate(date))
        
        df.dateFormat = "Y"
        
        var year: Int! = Int(df.stringFromDate(date))
    
        picker.selectRow(month-1, inComponent: 0, animated: true)
        // years start from 2010
        picker.selectRow(year-2010, inComponent: 1, animated: true)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let dummyView = UIView (frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        tfMonth.inputView = dummyView
    }
 

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                backToMain()
            default:
                break
            }
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         self.tfMonth.text = "\(months[picker.selectedRowInComponent(0)]) / \(years[picker.selectedRowInComponent(1)])"
    }
    
    

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return months.count
            
        }
            
        else {
            
            return years.count
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
  
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == 0 {
            
            return months[row]
        }
            
        else {
            
            return years[row]
        }
        
        
    }
    


    
    func backToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mainView") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func saveBudget(sender: AnyObject) {
        
        let budget = tfBudget.text
        let month = picker.selectedRowInComponent(0)
        let year = picker.selectedRowInComponent(1)
        
        let budgetyear = years[year]
        
        print("Budget for \(month) / \(budgetyear) is \(budget)")
        
        let monthlyBudget = Budget()
        monthlyBudget.budgetId = NSUUID().UUIDString
        monthlyBudget.year = (budgetyear as NSString).integerValue
        monthlyBudget.month = month
        monthlyBudget.budget = (budget as NSString).doubleValue
        
        budgetDAO.saveBudget(monthlyBudget)
        budgetNetwork.uploadToServer(monthlyBudget)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
