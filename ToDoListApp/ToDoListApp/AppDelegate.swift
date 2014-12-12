//
//  AppDelegate.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIAlertViewDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Sound, categories: nil))
        }        // Override point for customization after application launch.
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
     func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification)
    {
        
        let deadlineTask = notification.userInfo as [String:String]?
        
        if let todo = deadlineTask
        {
            let currentTaskInfo = todo["timesup"]!
            let message = String(format: "你的任务截止日期是 %@，目前进度是%@。",  currentTaskInfo,currentTaskInfo)
            
            let alert = UIAlertView(title: "Times UP", message: message, delegate: self, cancelButtonTitle: "Snooze", otherButtonTitles: "Cancel Alarm", "ss")
//            alert.show()

        }
      
        
  

    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        //afconvert -f caff -d LEI16@44100 -c 1 yourfile.wav yourfile.caf
        if(buttonIndex==0)
        {
            let date =  NSDate()
            let snoozeTime = date.dateByAddingTimeInterval(5)
            let notification =  UILocalNotification()
            notification.fireDate = snoozeTime
            notification.alertBody = "Time To Wake Up"
            notification.soundName  = UILocalNotificationDefaultSoundName
           // notification.soundName = "Alarm.mp3"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        else
        {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            println("Cancel Alarm Button")
 
        }

    }
}

