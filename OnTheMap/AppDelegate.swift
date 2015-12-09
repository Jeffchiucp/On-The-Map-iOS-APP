//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//
import UIKit

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: UIApplicationDelegate
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Notifies the Facebook SDK events system that the app has launched and, when appropriate, logs an "activated app" event
        FacebookClient.activeApp()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Ensures proper use of the Facebook SDK
        return FacebookClient.setupWithOptions(application, launchOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        // Handle interaction with the native Facebook app or Safari as part of SSO authorization flow or Facebook dialogs
        return FacebookClient.processURL(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}