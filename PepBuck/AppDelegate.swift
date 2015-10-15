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
    var initialViewController: UIViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("name") != nil {
            name = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("circleCompletion") != nil {
            circleCompletion = NSUserDefaults.standardUserDefaults().objectForKey("circleCompletion") as! Double
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("payRate") != nil {
            payRate = NSUserDefaults.standardUserDefaults().objectForKey("payRate") as! Double
        }

        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
           
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
   
        if NSUserDefaults.standardUserDefaults().objectForKey("name") != nil {
        name = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("circleCompletion") != nil {
        circleCompletion = NSUserDefaults.standardUserDefaults().objectForKey("circleCompletion") as! Double
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("payRate") != nil {
        payRate = NSUserDefaults.standardUserDefaults().objectForKey("payRate") as! Double
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("startTime") != nil {
            startTime = NSUserDefaults.standardUserDefaults().objectForKey("startTime") as! NSDate }

        
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

