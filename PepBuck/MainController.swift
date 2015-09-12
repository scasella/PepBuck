//
//  WelcomeController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var circleCompletion = 1.00
var startNowToggle = false
var toggleSaveTime = false
var seconds = 0
var savedTime = NSDate()

var date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)

class MainController: UIViewController {
    
    var coinLabelPay = 0.00
    var timer = NSTimer()
    var pauseToggle = false
    var newSession = true
    
    enum timerStatus {
        case toStart
        case toPause
        case toResume
    }
    
    enum settingEnum {
        case None
        case Pay
        case Circle
        case Adjust
    }
    
    var settingsSelect = settingEnum.None

    
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var settingsLabel: SpringLabel!
    @IBOutlet var circleButton: SpringButton!
    @IBOutlet var adjustButton: SpringButton!
    @IBOutlet var payButton: SpringButton!
    @IBOutlet var settingsField: UITextField!
    @IBOutlet var settingsView: SpringView!
    @IBOutlet var mainView: SpringView!
    @IBOutlet var earningsView: SpringView!
    @IBOutlet var springImage: SpringImageView!
    @IBOutlet var invisiblePlay: SpringButton!
    @IBOutlet var coinLabel: SpringLabel!
    @IBOutlet var endShiftButton: UIButton!
    @IBOutlet var coinImage: SpringImageView!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var playButton: SpringButton!
    @IBOutlet var timerCircle: CircularProgressView!
    @IBOutlet var springView: SpringView!
    
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var earningsButton: UIButton!
    
    @IBAction func playPressed(sender: SpringButton) {
        if pauseToggle == false {
        
        playButton.setTitle("Pause", forState: UIControlState.Normal)
        //invisiblePlay.hidden = false
        settingsButton.enabled = false
        earningsButton.enabled = false
        endShiftButton.hidden = true
        timerLabel.hidden = false
        setupGame()
        subtractTime()
        toggleSaveTime = true
        newSession = false
        pauseToggle = true
            
        } else {
        
        timer.invalidate()
        toggleSaveTime = false
        playButton.setTitle("Start", forState: UIControlState.Normal)
        //invisiblePlay.hidden = true
        endShiftButton.hidden = false
        settingsButton.enabled = true
        earningsButton.enabled = true
        pauseToggle = false
        
        }
    }
    
    
    
    @IBAction func endShiftPressed(sender: AnyObject) {
        invisiblePlay.hidden = true
        timerLabel.hidden = true
        playButton.hidden = true
        coinLabel.hidden = false
        coinImage.hidden = false
        endShiftButton.hidden = true
 
        timerCircle.value = CGFloat(0.0)
        coinLabel.text = "+$\(coinLabelPay)"
        coinImage.duration = 4.0
        coinLabel.duration = 4.0
        
        coinLabel.animate()
        coinImage.animateNext {
            self.coinLabel.hidden = true
            self.coinImage.hidden = true
            seconds = 0
            self.timerLabel.hidden = true
            self.playButton.hidden = false
            self.invisiblePlay.hidden = false
            self.performSegueWithIdentifier("refreshView", sender: self)
            
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
        let oldPay = round(payRate * Double(seconds / 10) / 60 / 60 * 100) / 100
        
        seconds++
        
        let newSecs = Double(seconds)
        let newPay = round(payRate * Double(seconds / 10) / 60 / 60 * 100) / 100
        coinLabelPay = newPay

        totalHours = (totalHours - oldSecs + newSecs) / 60 / 60
        totalPay = totalPay - oldPay + newPay
        
        timerLabel.text = "$\(newPay)"
        timerCircle.value = CGFloat(payRate * Double(seconds / 10 ) / 60 / 60 % circleCompletion)
        }
    
    
    @IBAction func earningsButtonPressed(sender: AnyObject) {
        /* springView.animation = "flipX"
       springView.duration = 2.5
        springView.animate() */
        settingsButton.enabled = false
        earningsButton.enabled = false
        earningsView.duration = 1.5
        mainView.duration = 1.5
        mainView.animation = "fall"
        mainView.force = 4.0
        earningsView.animation = "slideUp"
        earningsView.force = 4.0
        mainView.animateToNext() {
              self.mainView.y = 400
        }
        earningsView.animate()
        //mainView.hidden = true
        earningsView.hidden = false
    }
    
    
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        settingsButton.enabled = false
        earningsButton.enabled = false
        springView.animation = "fall"
        springView.animate()
        settingsView.hidden = false
        
    }
    
    
    
    @IBAction func earningsBackPressed(sender: AnyObject) {
        earningsView.animation = "fall"
        earningsView.duration = 1.5
        mainView.animation = "slideUp"
        mainView.duration = 1.5
        mainView.force = 4.0
        earningsView.animate()
        mainView.animate()
        settingsButton.enabled = true
        earningsButton.enabled = true
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            if startNowToggle == true {
            playPressed(SpringButton())
            startNowToggle = false 
        }
        
        animator = UIDynamicAnimator(referenceView: view)

               
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSettings" {
            previousViewIsMain = true
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!

    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    
    
    @IBAction func handleGesture(sender: AnyObject) {
        let myView = springView
        let location = sender.locationInView(view)
        let boxLocation = sender.locationInView(springView)
        
        if sender.state == UIGestureRecognizerState.Began {
            animator.removeBehavior(snapBehavior)
            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(myView.bounds), boxLocation.y - CGRectGetMidY(myView.bounds));
            attachmentBehavior = UIAttachmentBehavior(item: myView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeBehavior(attachmentBehavior)
            
            snapBehavior = UISnapBehavior(item: myView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translationInView(view)
          /*  if translation.y > 100 {
                animator.removeAllBehaviors()
                
                var gravity = UIGravityBehavior(items: [springView])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
            } */
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
            
            let newHours = totalHours - (settingsField.text as! NSString).doubleValue
            totalPay = totalPay + newHours * payRate
            
            NSUserDefaults.standardUserDefaults().setObject(totalHours, forKey: "totalHours")
            NSUserDefaults.standardUserDefaults().setObject(totalPay, forKey: "totalPay")
            
        default :
            println("test")
            
        }
    }

    
    
    @IBAction func settingsPressed(sender: SpringButton) {
        
        if sender.restorationIdentifier == "Pay" {
            
            settingsLabel.text = "Hourly Pay"
            settingsButtonsSwitch()
            sender.setBackgroundImage(UIImage(named: "SettingsPayFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Pay
            
            
        } else if sender.restorationIdentifier == "Circle" {
            
            settingsLabel.text = "Circle Finish"
            settingsButtonsSwitch()
            sender.setBackgroundImage(UIImage(named: "SettingsCircleFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Circle
            
        } else {
            
            settingsLabel.text = "Adjust Time"
            settingsButtonsSwitch()
            sender.setBackgroundImage(UIImage(named: "SettingsAdjustFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Adjust
            
        }
        
        settingsField.becomeFirstResponder()
    }
    
    
    
    func settingsButtonsSwitch() {
        payButton.setBackgroundImage(UIImage(named: "SettingsPayEmpty.png"), forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named: "SettingsCircleEmpty.png"), forState: UIControlState.Normal)
        adjustButton.setBackgroundImage(UIImage(named: "SettingsAdjustEmpty.png"), forState: UIControlState.Normal)
        //tapLabel.hidden = true
        settingsField.hidden = false
        saveButton.alpha = 1.0
        saveButton.enabled = true
    }
    
    

    @IBAction func backPressed(sender: AnyObject) {
        performSegueWithIdentifier("refreshView", sender: self)
    }
    
    
}
