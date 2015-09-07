//
//  SettingsController.swift
//  PepBuck
//
//  Created by Stephen Casella on 9/3/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet var tapLabel: SpringLabel!
    @IBOutlet var payButton: SpringButton!
    @IBOutlet var circleButton: SpringButton!
    @IBOutlet var adjustButton: SpringButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var settingsLabel: SpringLabel!
    @IBOutlet var settingsField: UITextField!
    
    enum settingEnum {
        case None
        case Pay
        case Circle
        case Adjust
    }

    var settingsSelect = settingEnum.None
    
    @IBAction func settingsPressed(sender: SpringButton) {
        if sender.restorationIdentifier == "Pay" {
       
            settingsLabel.text = "Hourly Pay"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsPayFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Pay
        
            
        } else if sender.restorationIdentifier == "Circle" {
        
            settingsLabel.text = "Circle Finish"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsCircleFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Circle
       
        } else {
            
            settingsLabel.text = "Adjust Time"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsAdjustFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Adjust

        }
    }
    
    
    
    @IBAction func savePressed(sender: AnyObject) {
        switch settingsSelect {
            
        case .Pay:
            payRate = (settingsField.text as NSString).doubleValue
            NSUserDefaults.standardUserDefaults().setObject(payRate, forKey: "payRate")
            
            
        case .Circle:
            
             NSUserDefaults.standardUserDefaults().setObject(circleCompletion, forKey: "circleCompletion")
            
        case .Adjust:
            
            let newHours = totalHours - (settingsLabel.text as! NSString).doubleValue
            totalPay = totalPay + newHours * payRate
            
             NSUserDefaults.standardUserDefaults().setObject(totalHours, forKey: "totalHours")
             NSUserDefaults.standardUserDefaults().setObject(totalPay, forKey: "totalPay")
            
        default :
            println("test")
       
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        switch previousViewIsMain {
        case true: performSegueWithIdentifier("toMain", sender: self)
        case false:
            performSegueWithIdentifier("toReturn", sender: self)
        default :
            println("test")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func buttonsNotToggled() {
        payButton.setBackgroundImage(UIImage(named: "SettingsPayEmpty.png"), forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named: "SettingsCircleEmpty.png"), forState: UIControlState.Normal)
        adjustButton.setBackgroundImage(UIImage(named: "SettingsAdjustEmpty.png"), forState: UIControlState.Normal)
        tapLabel.hidden = true
        settingsLabel.hidden = false
        settingsField.hidden = false
        saveButton.alpha = 1.0
        saveButton.enabled = true
        settingsLabel.becomeFirstResponder()
    }

}