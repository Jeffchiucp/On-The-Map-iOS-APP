//
//  OTMTableViewController.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import UIKit

// MARK: - OTMTableViewController: UITableViewController

class OTMTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let otmDataSource = OTMDataSource.sharedDataSource()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = otmDataSource
        NSNotificationCenter.defaultCenter().addObserver(self, selector: ParseClient.Selectors.StudentLocationsDidUpdate, name: "\(ParseClient.Objects.StudentLocation)\(ParseClient.Notifications.ObjectUpdatedError)", object: nil)
    }
    
    // MARK: Data Source
    
    func studentLocationsDidUpdate() {
        tableView.reloadData()
    }
    
    // MARK: Display Alert
    
    private func displayAlert(message: String) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.Dismiss, style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let studentMediaURL = otmDataSource.studentLocations[indexPath.row].student.mediaURL
        
        if let mediaURL = NSURL(string: studentMediaURL) {
            if UIApplication.sharedApplication().canOpenURL(mediaURL) {
                UIApplication.sharedApplication().openURL(mediaURL)
            } else {
                displayAlert(AppConstants.Errors.CannotOpenURL)
            }
        }
    }
}
