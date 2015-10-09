//
//  RoutingController.swift
//  PepBuck
//
//  Created by Stephen Casella on 10/8/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit

class RoutingController: UIViewController {
    
    override func viewDidLoad() {
       

    }
    
    override func viewDidAppear(animated: Bool) {
        if name != "" {
            performSegueWithIdentifier("toMain", sender: self)
        } else {
            performSegueWithIdentifier("toSetup", sender: self)
        }
    }

}
