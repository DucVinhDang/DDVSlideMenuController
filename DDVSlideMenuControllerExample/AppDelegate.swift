//
//  AppDelegate.swift
//  DDVSlideMenuControllerExample
//
//  Created by Đặng Vinh on 5/4/15.
//  Copyright (c) 2015 DVISoft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        var centerVC = CenterVC(nibName: "CenterVC", bundle: nil)
        var leftVC = LeftVC(nibName: "LeftVC", bundle: nil)
        var rightVC = RightVC(nibName: "RightVC", bundle: nil)
        
//        var topVC = TopVC(nibName: "TopVC", bundle: nil)
//        var bottomVC = BottomVC(nibName: "BottomVC", bundle: nil)
        
        centerVC.addLeftToggleButton(title: "Left")
        centerVC.addRightToggleButton(title: "Right")
        
        var centerNav = UINavigationController(rootViewController: centerVC)
        var leftNav = UINavigationController(rootViewController: leftVC)
        var rightNav = UINavigationController(rootViewController: rightVC)
        
        var ddvSlideMC = DDVSlideMenuController(centerViewController: centerNav, leftViewController: leftNav, rightViewController: rightNav)
        ddvSlideMC.delegate = centerVC
        
//        ddvSlideMC.addTopViewController(topVC)
//        ddvSlideMC.addBottomViewController(bottomVC)
        
        window?.rootViewController = ddvSlideMC
        window?.makeKeyAndVisible()
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


}

