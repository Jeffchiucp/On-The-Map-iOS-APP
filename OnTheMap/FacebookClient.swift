//
//  FacebookClient.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import Foundation

// MARK: - UdacityClient

class FacebookClient {
    
    // MARK: Properties
    
    private let loginManager = FBSDKLoginManager()
    
    // MARK: Singleton Instance
    
    private static var sharedInstance = FacebookClient()
    
    class func sharedClient() -> FacebookClient {
        return sharedInstance
    }
    
    // MARK: Class Functions
    
    class func activeApp() {
        // Notifies the Facebook SDK events system that the app has launched and, when appropriate, logs an "activated app" event
        FBSDKAppEvents.activateApp()
    }
    
    class func setupWithOptions(application: UIApplication, launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Ensures proper use of the Facebook SDK
        FBSDKSettings.setAppURLSchemeSuffix(FacebookClient.Common.URLSuffix)
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    class func processURL(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        // Handle interaction with the native Facebook app or Safari as part of SSO authorization flow or Facebook dialogs
        if url.scheme == FacebookClient.Common.URLScheme {
            return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        } else {
            return true
        }
    }
    
    // MARK: Access Token
    
    func currentAccessToken() -> FBSDKAccessToken! {
        return FBSDKAccessToken.currentAccessToken()
    }
    
    // MARK: Logout
    
    func logout() {
        loginManager.logOut()
    }
}