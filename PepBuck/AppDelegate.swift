//
//  AppDelegate.swift
//  PepBuck
//
//  Created by Stephen Casella on 8/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        if toggleSaveTime == true {
            NSUserDefaults.standardUserDefaults().setObject(toggleSaveTime, forKey: "toggleSaveTime")
          savedTime = NSDate()
            NSUserDefaults.standardUserDefaults().setObject(savedTime, forKey: "savedTime")
            NSUserDefaults.standardUserDefaults().setObject(seconds, forKey: "seconds")
        }
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
         NSUserDefaults.standardUserDefaults().objectForKey("name")
        
        
        /* if name == "" {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)

            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("SetupController") as! UIViewController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }*/
        
        NSUserDefaults.standardUserDefaults().objectForKey("circleCompletion")
        payRate = NSUserDefaults.standardUserDefaults().objectForKey("payRate") as! Double
       
        if toggleSaveTime == true {
            NSUserDefaults.standardUserDefaults().objectForKey("seconds")
            NSUserDefaults.standardUserDefaults().objectForKey("savedTime")
            
            let elapsedTime = NSDate().timeIntervalSinceDate(savedTime)
            seconds = seconds + Int(round(Double(elapsedTime)))
            println(seconds)
        }

        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

