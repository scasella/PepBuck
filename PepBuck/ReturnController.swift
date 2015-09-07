//
//  ReturnController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/20/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var previousViewIsMain = false 

class ReturnController: UIViewController {
    
    @IBAction func buttonPressed(sender: SpringButton) {
    
        sender.animation = "zoomOut"
        sender.duration =  1.0
        sender.animateNext {
            
            switch sender.restorationIdentifier! {
                
            case "start":
            startNowToggle = true
            self.performSegueWithIdentifier("toMain", sender: self)
        
            case "earnings":
                previousViewIsMain = false
                self.performSegueWithIdentifier("toEarnings", sender: self)
                
            default:
                previousViewIsMain = false
                 self.performSegueWithIdentifier("toSettings", sender: self)
            }
        
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

