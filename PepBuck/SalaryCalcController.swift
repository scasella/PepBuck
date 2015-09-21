//
//  SalaryCalcController.swift
//  PepBuck
//
//  Created by Stephen Casella on 9/14/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class SalaryCalcController: UIViewController {
    
    var firstLabelShowing = true
    var salary = 0.00
    var hours = 0.00
    
    @IBOutlet var whatIsYourSalaryLabel: SpringLabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var howManyHoursLabel: SpringLabel!
    
    @IBAction func submitPressed(sender: AnyObject) {
        if firstLabelShowing == true {
            salary = (textField.text as! NSString).doubleValue
            textField.text = ""
            firstLabelShowing = false
            whatIsYourSalaryLabel.x = 1000
            whatIsYourSalaryLabel.duration = 1.5
            whatIsYourSalaryLabel.animateTo()
            howManyHoursLabel.hidden = false 
            howManyHoursLabel.animate()
        } else {
            hours = (textField.text as! NSString).doubleValue
            firstLabelShowing = true 
            payRate = salary / 52 / hours
            NSUserDefaults.standardUserDefaults().setObject(payRate, forKey: "payRate")
            performSegueWithIdentifier("toMain", sender: self)
            
    }
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        
    }


}
