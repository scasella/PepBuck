//
//  SettingsController.swift
//  PepBuck
//
//  Created by Stephen Casella on 9/3/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet var payButton: SpringButton!
    @IBOutlet var circleButton: SpringButton!
    @IBOutlet var adjustButton: SpringButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var settingsLabel: SpringLabel!
    @IBOutlet var settingsField: UITextField!
    
    @IBAction func settingsPressed(sender: SpringButton) {
        if sender.restorationIdentifier == "Pay" {
       
            settingsLabel.text = "Hourly Pay"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsPayFull.png"), forState: UIControlState.Normal)
        
            
        } else if sender.restorationIdentifier == "Circle" {
        
            settingsLabel.text = "Circle Finish"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsCircleFull.png"), forState: UIControlState.Normal)
       
        } else {
            
            settingsLabel.text = "Adjust Time"
            buttonsNotToggled()
            sender.setBackgroundImage(UIImage(named: "SettingsAdjustFull.png"), forState: UIControlState.Normal)

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
        settingsLabel.hidden = false
        settingsField.hidden = false
        saveButton.alpha = 1.0
        saveButton.enabled = true
        settingsLabel.becomeFirstResponder()
    }

}