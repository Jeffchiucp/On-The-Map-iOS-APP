//
//  OTMDataSource.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import UIKit

// MARK: - OTMDataSource: NSObject

class OTMDataSource: NSObject {
    
    // MARK: Properties
    
    private let parseClient = ParseClient.sharedClient()
    var studentLocations = [StudentLocation]()
    var currentStudent: Student? = nil
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: Singleton Instance
    
    private static var sharedInstance = OTMDataSource()
    
    class func sharedDataSource() -> OTMDataSource {
        return sharedInstance
    }
    
    // MARK: Notifications
    
    private func sendDataNotification(notificationName: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil)
    }
    
    // MARK: Refresh Student Locations
    
    func refreshStudentLocations() {
        parseClient.studentLocations { (students, error) in
            if let _ = error {
                self.sendDataNotification("\(ParseClient.Objects.StudentLocation)\(ParseClient.Notifications.ObjectUpdatedError)")
            } else {
                self.studentLocations = students!
                self.sendDataNotification("\(ParseClient.Objects.StudentLocation)\(ParseClient.Notifications.ObjectUpdated)")
            }
        }
    }
}

// MARK: - StudentLocationDataSource: UITableViewDataSource

extension OTMDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
        let studentLocation = studentLocations[indexPath.item]
        cell.configureWithStudentLocation(studentLocation)
        return cell
    }
}