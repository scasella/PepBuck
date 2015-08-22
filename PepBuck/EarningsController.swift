//
//  WalletController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/22/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var periodStart = ""
var latestDate = ""

var totalPay = 0.00
var totalHours = 0.00

class EarningsController: UIViewController {
    
    @IBOutlet var totalPayLabel: SpringLabel!
    @IBOutlet var totalHoursLabel: SpringLabel!
    @IBOutlet var periodStartLabel: SpringLabel!
    @IBOutlet var latestDateLabel: SpringLabel!
    
    @IBAction func resetPressed(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Reset Earnings", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes!", style: .Default, handler: { (action: UIAlertAction!) in
            totalHours = 0.00
            totalPay = 0.00
            periodStart = ""
            latestDate = ""
            
            self.resetLabels()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            println("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPayLabel.text = "$\(totalPay)"
        totalHoursLabel.text = "\(round(totalHours * 100)/100) hours"
        
        periodStartLabel.text = "Period start date: \(periodStart)"
        latestDateLabel.text = "Latest date: \(latestDate)"
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func resetLabels() {
        totalPayLabel.text = "$0.00"
        totalHoursLabel.text = "0.00 hours"
        periodStartLabel.text = ""
        latestDateLabel.text = ""
    }


}