//
//  ParseConstants.swift
//  OnTheMap
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//
import UIKit

// MARK: - ParseClient (Constants)

extension ParseClient {
    
    // MARK: Components
    
    struct Components {
        static let Scheme = "https"
        static let Host = "api.parse.com"
        static let Path = "/1/classes"
    }
    
    // MARK: Errors
    
    struct Errors {
        static let Domain = "ParseClient"
        static let NoRecordAtKey = "No object record at key."
        static let NoRecords = "No objects found."
        static let CouldNotPostLocation = "Student location could not be posted."
        static let CouldNotUpdateLocation = "Student location could not be updated."
    }
    
    // MARK: Objects
    
    struct Objects {
        static let StudentLocation = "/StudentLocation"
    }

    // MARK: ParameterKeys
    
    struct ParameterKeys {
        static let Limit = "limit"
        static let Order = "order"
        static let Where = "where"
        static let UniqueKey = "uniqueKey"
    }
    
    // MARK: ParameterValues
    
    struct ParameterValues {
        static let OneHundred = 100
        static let TwoHundred = 200
        static let MostRecentlyUpdated = "-updatedAt"
        static let MostRecentlyCreated = "-createdAt"
    }
    
    // MARK: HeaderKeys
    
    struct HeaderKeys {
        static let AppId = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
        static let Accept = "Accept"
        static let ContentType = "Content-Type"
    }
    
    // MARK: HeaderValues
    
    struct HeaderValues {
        static let AppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let JSON = "application/json"
    }
    
    // MARK: BodyKeys
    
    struct BodyKeys {
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
    }
    
    // MARK: JSONResponseKeys
    
    struct JSONResponseKeys {
        static let Error = "error"
        static let Results = "results"
        static let ObjectID = "objectId"
        static let UpdatedAt = "updatedAt"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
    }
    
    // MARK: DefaultValues
    
    struct DefaultValues {
        static let ObjectID = "[No Object ID]"
        static let UniqueKey = "[No Unique Key]"
        static let FirstName = "[No First Name]"
        static let LastName = "[No Last Name]"
        static let MediaURL = "[No Media URL]"
        static let MapString = "[No Map String]"
    }
    
    // MARK: Selectors
    
    struct Selectors {
        static let StudentLocationsDidUpdate: Selector = "studentLocationsDidUpdate"
        static let StudentLocationsDidError: Selector = "studentLocationsDidError"
    }
    
    // MARK: Notifications
    
    struct Notifications {
        static let ObjectUpdated = "Updated"
        static let ObjectUpdatedError = "Error"
    }
}