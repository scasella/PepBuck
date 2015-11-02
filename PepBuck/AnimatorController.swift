//
//  AnimatorController.swift
//  PepBuck
//
//  Created by Stephen Casella on 11/1/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit

var shouldAnimateStar = true

class AnimatorController: UIViewController {
    
    @IBOutlet weak var animationImage: SpringImageView!

    override func viewDidAppear(animated: Bool) {
        if shouldAnimateStar == true {
        
        animationImage.animateNext {
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            
        })
        //self.performSegueWithIdentifier("backToMain", sender: self)
        } } else {
        
        animationImage.image = UIImage(named: "CoinImage.png")
        animationImage.animateNext {
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                
            })

        }
    
        }
    }
    
}
