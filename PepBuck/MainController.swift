//
//  WelcomeController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    var seconds = 0
    var timer = NSTimer()
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var playButton: SpringButton!
    @IBOutlet var timerCircle: CircularProgressView!
    
    
    
    @IBAction func playPressed(sender: SpringButton) {
        timerLabel.hidden = false
        playButton.hidden = true
        setupGame()
        subtractTime()
    }
    
    
    
    func setupGame() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
    }
    
    
    
    func subtractTime() {
        seconds++
        timerLabel.text = "$\(round(payRate * Double(seconds) / 60 / 60 * 100)/100)"
        timerCircle.value = CGFloat(payRate * Double(seconds) / 60 / 60 % 1)
        if  timerCircle.value >= 1.0 {
            timerCircle.value = 0.0
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
