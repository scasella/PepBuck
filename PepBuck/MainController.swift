//
//  WelcomeController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var startNowToggle = false

var date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)

class MainController: UIViewController {
    
    var seconds = 0
    var timer = NSTimer()
    var pauseToggle = false
    var newSession = true
    
    enum timerStatus {
        case toStart
        case toPause
        case toResume
    }

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var playButton: SpringButton!
    @IBOutlet var timerCircle: CircularProgressView!
    @IBOutlet var springView: SpringView!
    
    
    @IBAction func playPressed(sender: SpringButton) {
        if pauseToggle == false {
        
        timerLabel.hidden = false
        playButton.hidden = true
        setupGame()
        subtractTime()
        newSession = false
        pauseToggle = true
            
        } else {
            
        timer.invalidate()
        timerLabel.hidden = true
        playButton.hidden = false
        pauseToggle = false
        
        }
    }
    
    
    
    func setupGame() {
        
        if newSession == true {
            latestDate = "\(date)"
            if periodStart == "" {
                periodStart = "\(date)"
            }
        
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
    }
    
    
    
    func subtractTime() {
       
        let oldSecs = Double(seconds)
        let oldPay = round(payRate * Double(seconds / 10 ) / 60 / 60 * 100)/100
        
        seconds++
        
        let newSecs = Double(seconds)
        let newPay = round(payRate * Double(seconds / 10 ) / 60 / 60 * 100)/100

        totalHours = (totalHours - oldSecs + newSecs) / 60 / 60
        totalPay = totalPay - oldPay + newPay
        
        timerLabel.text = "$\(newPay)"
        timerCircle.value = CGFloat(payRate * Double(seconds / 10 ) / 60 / 60 / 10 % 1)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if startNowToggle == true {
            timerLabel.hidden = false
            playButton.hidden = true
            setupGame()
            subtractTime()
        }
               
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
