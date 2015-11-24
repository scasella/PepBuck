//
//  WelcomeController.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit
import iAd

var getPause = false
var totalPauseTime = 0.0
var onlyShowPepBuck = false
var goalName = ""

class MainController: UIViewController, ADBannerViewDelegate {
    
    //Handle iAD 
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        UIView.animateWithDuration(0.5) { () -> Void in
             self.bannerAd.alpha = 1
        }
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {

            UIView.animateWithDuration(0.5) { () -> Void in
                self.bannerAd.alpha = 0
            }
    }
    /// END Handle iAd
    
    
    var newSession = true
    var coinLabelPay = 0.00
    var timer = NSTimer()
    var pauseToggle = false
    var pauseTimeStart = NSDate()
    var pauseTimeEnd = NSDate()
    var pauseUsed = false
    var sessionPay = 0.00
    var sessionHours = 0.00
    @IBOutlet weak var bannerAd: ADBannerView!
    
    enum settingEnum {
        case None
        case Pay
        case Circle
        case Adjust
        case Name
    }
    
    var settingsSelect = settingEnum.None

    
    @IBOutlet weak var goalText: SpringLabel!
    @IBOutlet weak var nameLabel: SpringLabel!
    @IBOutlet weak var welcomeLabel: SpringLabel!
    @IBOutlet weak var pepBuckLabel: SpringLabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsLabel: SpringLabel!
    @IBOutlet weak var circleButton: SpringButton!
    @IBOutlet weak var adjustButton: SpringButton!
    @IBOutlet weak var payButton: SpringButton!
    @IBOutlet weak var settingsField: UITextField!
    @IBOutlet weak var settingsView: SpringView!
    @IBOutlet weak var mainView: SpringView!
    @IBOutlet weak var earningsView: SpringView!
    @IBOutlet weak var springImage: SpringImageView!
    @IBOutlet weak var coinLabel: SpringLabel!
    @IBOutlet weak var endShiftButton: UIButton!
    @IBOutlet weak var coinImage: SpringImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: SpringButton!
    @IBOutlet weak var timerCircle: CircularProgressView!
    @IBOutlet weak var springView: SpringView!
    @IBOutlet weak var totalPayLabel: UILabel!
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var periodStartLabel: UILabel!
    @IBOutlet weak var latestDateLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var earningsButton: UIButton!
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    
    
    func toggleEarningsSettings(show: Bool) {
        if show == true {
            settingsButton.enabled = true
            settingsButton.alpha = 1.0
            earningsButton.enabled = true
            earningsButton.alpha = 1.0
        } else {
            settingsButton.enabled = false
            settingsButton.alpha = 0.5
            earningsButton.enabled = false
            earningsButton.alpha = 0.5
        }
        
        
    }
    
    
    
    @IBAction func playPressed(sender: SpringButton) {
        if pauseToggle == false {
        pauseToggle = true
        playButton.setTitle("Pause", forState: UIControlState.Normal)
        //invisiblePlay.hidden = false
    
            
        if newSession == true {
            setupGame(true)
        } else {
            setupGame(false)
            pauseTimeEnd = NSDate()
            totalPauseTime = totalPauseTime + pauseTimeEnd.timeIntervalSinceDate(pauseTimeStart)
        }
            
        subtractTime()
        newSession = false
       
        timerLabel.hidden = false
        endShiftButton.hidden = true
            
        toggleEarningsSettings(false)
        
        } else {
            
        pauseTimeStart = NSDate()
        pauseUsed = true
        timer.invalidate()
        toggleSaveTime = false
        playButton.setTitle("Start", forState: UIControlState.Normal)
        endShiftButton.hidden = false
        pauseToggle = false
            
      
        
        }
    }
    
    
    
    @IBAction func endShiftPressed(sender: AnyObject) {
        
        newSession = true
        
        timerLabel.hidden = true
        playButton.hidden = true
        coinLabel.hidden = false
        coinImage.hidden = false
        endShiftButton.hidden = true
        
        totalHours = totalHours + sessionHours
        totalPay = totalPay + sessionPay
        
        NSUserDefaults.standardUserDefaults().setObject(totalHours, forKey: "totalHours")
        NSUserDefaults.standardUserDefaults().setObject(totalPay, forKey: "totalPay")
        
        timerCircle.value = CGFloat(0.0)
        coinLabel.text = "\(timerLabel.text!)"
        coinImage.duration = 4.0
        coinLabel.duration = 4.0
        onlyShowPepBuck = true 
        
        coinLabel.animate()
        coinImage.animateNext {
           self.performSegueWithIdentifier("refreshViewSegue", sender: self)
        }
        
    }
    
    
    
    func setupGame(sessionNew: Bool) {
        if sessionNew == true {
           
            newSession = false
            startTime = NSDate()
            let tempTime = startTime
            let date = NSDateFormatter.localizedStringFromDate(tempTime, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            NSUserDefaults.standardUserDefaults().setObject(startTime, forKey: "startTime")
           
            latestDate = "\(date)"
            NSUserDefaults.standardUserDefaults().setObject(latestDate, forKey: "latestDate")
            
            if periodStart == "" {
                periodStart = "\(date)"
                NSUserDefaults.standardUserDefaults().setObject(periodStart, forKey: "periodStart")
            }
            
            
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
       
    }
    
    
    
    
    var incrementer = 0.0
    
    
    
    func subtractTime() {
        
        let elapsedTime: Double?
        
        if pauseUsed == true {
            
            elapsedTime = NSDate().timeIntervalSinceDate(startTime) - totalPauseTime
    
        } else {
            
            elapsedTime = NSDate().timeIntervalSinceDate(startTime)
        }
        
        let convertToHours = elapsedTime! / 60 / 60
        
        sessionPay = convertToHours * payRate
        sessionHours = convertToHours
        
        timerLabel.text = "$\(round(elapsedTime! / 60 / 60 * payRate * 100) / 100)"
        let currentPay = (elapsedTime! / 60 / 60 * payRate / circleCompletion)
        let timerCalc = currentPay - Double(Int(currentPay))
        timerCircle.value = CGFloat(timerCalc)
        
    
            incrementer = circleCompletion * (sessionPay / circleCompletion - Double(Int(sessionPay / circleCompletion))) / (payRate / 60 / 60)
        
          //  incrementer = incrementer + 0.1
    
        
       // let limit = circleCompletion / (payRate / 60 / 60)
        
        
        if Int(starLabel.text as String!) < Int(sessionPay / circleCompletion) {
            starSetup()
            performSegueWithIdentifier("toAnimator", sender: self)
            self.incrementer = 0.0

        }
        
       
    }
    
    
    
    @IBAction func earningsButtonPressed(sender: AnyObject) {
        /* springView.animation = "flipX"
       springView.duration = 2.5
        springView.animate() */
        
        toggleEarningsSettings(false)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("totalHours") != nil {
            totalHours = NSUserDefaults.standardUserDefaults().objectForKey("totalHours") as! Double }
        if NSUserDefaults.standardUserDefaults().objectForKey("totalPay") != nil {
            totalPay = NSUserDefaults.standardUserDefaults().objectForKey("totalPay") as! Double }
        if NSUserDefaults.standardUserDefaults().objectForKey("periodStart") != nil {
            periodStart = NSUserDefaults.standardUserDefaults().objectForKey("periodStart") as! String }
        if NSUserDefaults.standardUserDefaults().objectForKey("latestDate") != nil {
            latestDate = NSUserDefaults.standardUserDefaults().objectForKey("latestDate") as! String }
        
        settingsButton.enabled = false
        earningsButton.enabled = false
        totalPayLabel.text = "$\(round(totalPay * 100)/100)"
        totalHoursLabel.text = "\(round(totalHours * 100)/100) hours"
        periodStartLabel.text = "Period start: \(periodStart)"
        latestDateLabel.text = "Last shift: \(latestDate)"
        earningsView.duration = 1.5
        mainView.duration = 1.5
        mainView.animation = "fall"
        mainView.force = 4.0
        earningsView.animation = "slideUp"
        earningsView.force = 4.0
        
        goalText.hidden = true
        mainView.animateToNext() {
              self.mainView.y = 400
        }
        earningsView.animate()
        //mainView.hidden = true
        earningsView.hidden = false
    }
    
    
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        
        settingsButtonsSwitch()
        saveButton.enabled = false
        settingsField.enabled = false
        settingsLabel.text = "Tap a button below"
        settingsField.text = ""
        toggleEarningsSettings(false)
        mainView.duration = 1.5
        mainView.animation = "fall"
        mainView.force = 4.0
        
        goalText.hidden = true
        mainView.animateToNext() {
            self.mainView.y = 400
        }
        pepBuckLabel.hidden = true
        
        settingsView.hidden = false
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      starSetup()
      
      bannerAd.delegate = self
      bannerAd.alpha = 0
      self.canDisplayBannerAds = true
 
        
        nameLabel.text = "\(name)"
        
        if startNowToggle == true {
            playPressed(SpringButton())
            startNowToggle = false 
        }
        
        if goalName != "" {
            goalText.text = "\(goalName)"
        } else {
            goalText.text = "$\(circleCompletion)"
        }
        
        if onlyShowPepBuck == false {
           
            goalText.hidden = true
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        if name == "" {
            performSegueWithIdentifier("toSetup", sender: self)
        }
        
        if onlyShowPepBuck == false {
        toggleEarningsSettings(false)
        pepBuckLabel.animate()
        welcomeLabel.animate()
        welcomeLabel.hidden = false
        nameLabel.hidden = false
   
        nameLabel.animateNext() {
            self.nameLabel.hidden = true
            self.welcomeLabel.hidden = true
         
            self.goalText.hidden = false
            self.goalText.animateNext(){
                self.toggleEarningsSettings(true)
            }
            } } else {
            onlyShowPepBuck = false 
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func starSetup() {
    
    let startCalc =  sessionPay / circleCompletion
    
    if startCalc > 0.98 {
    starImage.hidden = false
    } else {
    starImage.hidden = true
    }
    
    if Int(startCalc) >= 1 {
    starLabel.text = "\(Int(startCalc))"
        if Int(startCalc) > 1 {
    starLabel.hidden = false
        }
    } else {
    starLabel.hidden = true
    }
    
    }
    
    
    
    ///Snap-to-grid behavior
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
            if snapBehavior != nil {
                animator.removeBehavior(snapBehavior)
            }
            
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
            
           /* let translation = sender.translationInView(view)
            if translation.y > 100 {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
            } */
        }
    }
    
    
    
    
    
    
    /* Earnings View Code - Below
    =========================
    =========================
    =========================
    */
    
    @IBAction func earningsResetPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Alert", message: "Resert Earnings?", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction) in
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Yes", style: .Destructive, handler: { (action: UIAlertAction) in
            totalHours = 0.00
            totalPay = 0.00
            periodStart = ""
            latestDate = ""
            
             NSUserDefaults.standardUserDefaults().setObject(totalHours, forKey: "totalHours")
             NSUserDefaults.standardUserDefaults().setObject(totalPay, forKey: "totalPay")
             NSUserDefaults.standardUserDefaults().setObject(periodStart, forKey: "periodStart")
             NSUserDefaults.standardUserDefaults().setObject(latestDate, forKey: "latestDate")
            
            self.resetLabels()
            
        }))
       
        
         self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    
    func resetLabels() {
        totalPayLabel.text = "$0.00"
        totalHoursLabel.text = "0.00 hours"
        periodStartLabel.text = ""
        latestDateLabel.text = ""
    }
    
    
    
    @IBAction func earningsBackPressed(sender: AnyObject) {
       
        goalText.hidden = false
        earningsView.animation = "fall"
        earningsView.duration = 1.5
        mainView.animation = "slideUp"
        mainView.duration = 1.5
        mainView.force = 4.0
        earningsView.animate()
        mainView.animate()
        toggleEarningsSettings(true)
        
    }
    
 //END EARNINGS VIEW
   
    
    
    
    

/* Settings View Code - Below
    =========================
    =========================
    =========================
*/
    @IBAction func changeNamePressed(sender: AnyObject) {
        dollarLabel.hidden = true
        settingsField.resignFirstResponder()
        settingsField.keyboardType = UIKeyboardType.NamePhonePad
        settingsField.becomeFirstResponder()
        settingsField.text = ""
        settingsSelect = .Name
        settingsLabel.text = "Set Name"
        
    }
   
    
    
    @IBAction func savePressed(sender: AnyObject) {
        if settingsField.text != "" {
        switch settingsSelect {
            
        case .Pay:
            payRate = (settingsField.text as! NSString).doubleValue
            NSUserDefaults.standardUserDefaults().setObject(payRate, forKey: "payRate")
            showSettingsAlert("Hourly pay is now $\(payRate)")
            
            
        case .Circle:
            
            circleCompletion = (settingsField.text as! NSString).doubleValue
            NSUserDefaults.standardUserDefaults().setObject(circleCompletion, forKey: "circleCompletion")
             //showSettingsAlert("Circle completes every $\(circleCompletion) earned")
            
            
            
            //Goal Name Set
            ///////////////
            ///////////////
            var tField: UITextField!
            
            func configurationTextField(textField: UITextField!)
            {
                textField.placeholder = "Enter an item"
                tField = textField
            }
            
            
            func handleCancel(alertView: UIAlertAction!)
            {
                goalName = ""
                NSUserDefaults.standardUserDefaults().setObject(goalName, forKey: "goalName")
            }
            
            let alert = UIAlertController(title: "Add Goal Name?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addTextFieldWithConfigurationHandler(configurationTextField)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler:handleCancel))
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                goalName = tField.text as String!
                NSUserDefaults.standardUserDefaults().setObject(goalName, forKey: "goalName")
            }))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
            ///////////////
            ///////////////
            //Goal Name Set END
            

        
        case .Adjust:
            
            let newHours = (settingsField.text as! NSString).doubleValue - totalHours
            totalHours = (settingsField.text as! NSString).doubleValue
            totalPay = newHours * payRate + totalPay
            
            NSUserDefaults.standardUserDefaults().setObject(totalHours, forKey: "totalHours")
            NSUserDefaults.standardUserDefaults().setObject(totalPay, forKey: "totalPay")
            
             showSettingsAlert("Hours worked adjusted sucessfully")
        
            
        case .Name:
            
            name = settingsField.text!
            NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
            showSettingsAlert("Hi, \(name)!")
            
        default :
            print("test")
            
        }
            
        }
        
        settingsButtonsSwitch()
        settingsLabel.text = "Tap a button below"
         settingsField.text = ""
        settingsField.enabled = false
 
       
    }

    
    
    @IBAction func settingsPressed(sender: SpringButton) {
        
        settingsField.enabled = true
        saveButton.enabled = true 
        
        if sender.restorationIdentifier == "Pay" {
            
            settingsLabel.text = "Hourly Pay"
            settingsField.resignFirstResponder()
            settingsField.keyboardType = UIKeyboardType.DecimalPad
            settingsButtonsSwitch()
            dollarLabel.hidden = false
            changeNameButton.hidden = false
            sender.setBackgroundImage(UIImage(named: "SettingsPayFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Pay
            settingsField.text = "\(round(payRate * 100) / 100)"
            
        } else if sender.restorationIdentifier == "Circle" {
            
            settingsLabel.text = "Set Goal"
            settingsField.resignFirstResponder()
            settingsField.keyboardType = UIKeyboardType.DecimalPad
            settingsButtonsSwitch()
            dollarLabel.hidden = false
            sender.setBackgroundImage(UIImage(named: "SettingsCircleFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Circle
            settingsField.text = "\(circleCompletion)"
            
        } else {
            
            settingsLabel.text = "Adjust Time"
            settingsField.resignFirstResponder()
            settingsField.keyboardType = UIKeyboardType.DecimalPad
            settingsButtonsSwitch()
            dollarLabel.hidden = true
            sender.setBackgroundImage(UIImage(named: "SettingsAdjustFull.png"), forState: UIControlState.Normal)
            settingsSelect = .Adjust
            settingsField.text = "\(round(totalHours * 100) / 100)"
        
        }
        
        settingsField.becomeFirstResponder()
    }
    
    
    
    func settingsButtonsSwitch() {
        settingsField.keyboardType = UIKeyboardType.DecimalPad
        payButton.setBackgroundImage(UIImage(named: "SettingsPayEmpty.png"), forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named: "SettingsCircleEmpty.png"), forState: UIControlState.Normal)
        adjustButton.setBackgroundImage(UIImage(named: "SettingsAdjustEmpty.png"), forState: UIControlState.Normal)
        changeNameButton.hidden = true
        settingsField.hidden = false
        dollarLabel.hidden = true
        saveButton.alpha = 1.0
        saveButton.enabled = true
    }
    
    

    @IBAction func backPressed(sender: AnyObject) {
        settingsField.resignFirstResponder()
        springView.hidden = false
        
        if goalName != "" {
        goalText.text = "\(goalName)"
        } else {
        goalText.text = "$\(circleCompletion)"
        }
        
        dollarLabel.hidden = true 
        
        goalText.hidden = false
        mainView.animation = "slideUp"
        mainView.duration = 1.5
        mainView.force = 4.0
        mainView.animate()
        settingsButton.enabled = true
        earningsButton.enabled = true
        pepBuckLabel.hidden = false
        settingsView.hidden = true
        toggleEarningsSettings(true)
    }
    
    
    
   func showSettingsAlert(setting: String) {
        let alertController = UIAlertController(title: "Settings Updated", message:
            "\(setting)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
    
//END SETTINGS VIEW
    
    func setGoalLabel(goal: String) {
        goalText.text = goal
    }
    
}
