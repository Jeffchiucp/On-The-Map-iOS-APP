//
//  AppConstants.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//
import UIKit

// MARK: - AppConstants

struct AppConstants {
    
    // MARK: UI
    
    struct UI {
        static let LoginColorTop = UIColor(red: 1.0, green: 0.6, blue: 0.043, alpha: 1.0).CGColor
        static let LoginColorBottom = UIColor(red: 1.0, green: 0.435, blue: 0.0, alpha: 1.0).CGColor
        static let OTMBlueColor = UIColor(red: 0.275, green: 0.490, blue: 0.666, alpha: 1.0)
        static let OTMGreyColor = UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1.0)
    }
    
    // MARK: Alerts
    
    struct Alerts {
        static let OverwriteTitle = "Overwrite Location?"
        static let OverwriteMessage = "You've already posted a pin. Would you like to overwrite it?"
        static let LoginTitle = "Login Error"
    }
    
    // MARK: AlertActions
    
    struct AlertActions {
        static let Overwrite = "Overwrite"
        static let Cancel = "Cancel"
        static let Dismiss = "Dismiss"
    }
    
    // MARK: Errors
    
    struct Errors {
        static let UserPassEmpty = "Username or password empty."
        static let URLEmpty = "Must enter a URL."
        static let StudentAndPlacemarkEmpty = "Student and placemark not initialized."
        static let MapStringEmpty = "Must enter a Location."
        static let CouldNotGeocode = "Could not geocode the string."
        static let NoLocationFound = "No location found."
        static let PostStudentLocationFailed = "Student location could not be posted."
        static let CannotOpenURL = "Cannot open URL."
        static let CouldNotUpdateStudentLocations = "Could not update student locations."
    }
}