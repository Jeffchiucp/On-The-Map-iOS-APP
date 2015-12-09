//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: Common
    
    struct Common {
        static let SignUpURL = "https://www.udacity.com/account/auth#!/signup"
    }
    
    // MARK: Errors
    
    struct Errors {
        static let Domain = "UdacityClient"
        static let UnableToLogin = "Unable to login."
        static let UnableToLogout = "Unable to logout."
        static let NoUserData = "Cannot access user data."
    }
    
    // MARK: Components
    
    struct Components {
        static let Scheme = "https"
        static let Host = "www.udacity.com"
        static let Path = "/api"
    }
    
    // MARK: Methods
    
    struct Methods {
        static let Session = "/session"
        static let Users = "/users"
    }
    
    // MARK: Cookies
    
    struct Cookies {
        static let XSRFToken = "XSRF-TOKEN"
    }
    
    // MARK: HeaderKeys
    
    struct HeaderKeys {
        static let Accept = "Accept"
        static let ContentType = "Content-Type"
        static let XSRFToken = "X-XSRF-TOKEN"
    }
    
    // MARK: HeaderValues
    
    struct HeaderValues {
        static let JSON = "application/json"
    }
    
    // MARK: HTTPBodyKeys
    
    struct HTTPBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSONResponseKeys
    
    struct JSONResponseKeys {
        static let Account = "account"
        static let UserKey = "key"
        static let Status = "status"
        static let Session = "session"
        static let Error = "error"
        static let User = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }
}