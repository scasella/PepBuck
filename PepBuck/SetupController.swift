//
//  ViewController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class SetupController: UIViewController {
    
    var payToggle = false
    
    @IBOutlet var welcomeLabel: SpringLabel!
    @IBOutlet var pepBuckLabel: SpringLabel!
    @IBOutlet var entryField: UITextField!
    @IBOutlet var whatIsLabel: SpringLabel!
    @IBOutlet var submitButton: SpringButton!
    @IBOutlet var nameLabel: SpringLabel!
    @IBOutlet var whatIsHourLabel: SpringLabel!
    @IBOutlet var calcIcon: UIButton!
    
    @IBAction func submitTap(sender: AnyObject) {
        if payToggle == false {
        if entryField.text != "" {
        
        name = entryField.text
        name.replaceRange(name.startIndex...name.startIndex, with: String(name[name.startIndex]).capitalizedString)
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
        welcomeLabel.hidden = true
        pepBuckLabel.hidden = true
        nameLabel.text = "Hi, \(name)"
        nameLabel.hidden = false
        nameLabel.animation = "fadeIn"
        nameLabel.duration = 1.0
        nameLabel.animate()
        whatIsLabel.x = 1000
        whatIsLabel.duration = 1.5
        whatIsLabel.animateTo()
        whatIsHourLabel.hidden = false
        whatIsHourLabel.animation = "slideRight"
        whatIsHourLabel.duration = 1.5
        whatIsHourLabel.animate()
        entryField.text = ""
        calcIcon.hidden = false
        entryField.keyboardType = UIKeyboardType.DecimalPad
        entryField.resignFirstResponder()
        entryField.becomeFirstResponder()
        payToggle = true
         }
        } else {
            if entryField.text != "" {
            payRate = (entryField.text as NSString).doubleValue
            NSUserDefaults.standardUserDefaults().setObject(payRate, forKey: "payRate")
            performSegueWithIdentifier("toMain", sender: self)
            } }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.animateNext {
            self.welcomeLabel.animation = "squeezeRight"
            self.welcomeLabel.duration = 1.5
            self.welcomeLabel.animate()
        }
        
        pepBuckLabel.animateNext {
            self.pepBuckLabel.animation = "squeezeLeft"
            self.pepBuckLabel.delay = 0.2
            self.pepBuckLabel.duration = 1.5
            self.pepBuckLabel.animate()
            self.pepBuckLabel.animateNext {
                entryField.becomeFirstResponder()
            }
        }
        
        whatIsLabel.animateNext {
        self.whatIsLabel.animation = "fadeIn"
        self.whatIsLabel.delay = 1.0
        self.whatIsLabel.duration = 3.0
        self.whatIsLabel.animate()
            
    }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

