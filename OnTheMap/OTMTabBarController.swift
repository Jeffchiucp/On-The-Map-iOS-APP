//
//  OTMTabBarController.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//
import UIKit

// MARK: - OTMTabBarController: UITabBarController

class OTMTabBarController: UITabBarController {
    
    // MARK: Properties
    
    private let udacityClient = UdacityClient.sharedClient()
    private let parseClient = ParseClient.sharedClient()
    private let otmDataSource = OTMDataSource.sharedDataSource()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: ParseClient.Selectors.StudentLocationsDidError, name: "\(ParseClient.Objects.StudentLocation)\(ParseClient.Notifications.ObjectUpdatedError)", object: nil)
    }
    
    // MARK: Actions
    
    @IBAction func logout(sender: AnyObject) {
        udacityClient.logout { (success, error) in
            dispatch_async(dispatch_get_main_queue()) {
                FBSDKLoginManager().logOut()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func refreshStudentLocations(sender: AnyObject) {
        otmDataSource.refreshStudentLocations()
    }
    
    @IBAction func addStudentLocation(sender: AnyObject) {        
        // do we already have a location?
        if let currentStudent = otmDataSource.currentStudent {
            parseClient.studentLocationWithUserKey(currentStudent.uniqueKey) { (location, error) in
                dispatch_async(dispatch_get_main_queue()) {
                    if let location = location {
                        self.displayOverwriteAlert { (alert) in
                            self.launchPostingModal(location.objectID)
                        }
                    } else  {
                        self.launchPostingModal()
                    }
                }
            }
        }
    }
    
    // MARK: Data Source
    
    func studentLocationsDidError() {
        displayAlert(AppConstants.Errors.CouldNotUpdateStudentLocations)
    }
    
    // MARK: Display Alerts
    
    private func displayAlert(message: String) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.Dismiss, style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    private func displayOverwriteAlert(completionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertView = UIAlertController(title: AppConstants.Alerts.OverwriteTitle, message: AppConstants.Alerts.OverwriteMessage, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.Overwrite, style: .Default, handler: completionHandler))
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.Cancel, style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    private func launchPostingModal(objectID: String? = nil) {
        let postingViewController = self.storyboard!.instantiateViewControllerWithIdentifier("OTMPostingViewController") as! OTMPostingViewController
        if let objectID = objectID {
            postingViewController.objectID = objectID
        }
        self.presentViewController(postingViewController, animated: true, completion: nil)
    }
}
