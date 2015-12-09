//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

// MARK: - StudentLocation

struct StudentLocation {
    
    // MARK: Properties
    
    let objectID: String
    let student: Student
    let location: Location
    
    // MARK: Initializers
    
    init(dictionary: [String:AnyObject]) {
        
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String ?? ""
        
        // get student data
        let uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String ?? ParseClient.DefaultValues.ObjectID
        let firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? ParseClient.DefaultValues.FirstName
        let lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? ParseClient.DefaultValues.LastName
        let mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? ParseClient.DefaultValues.MediaURL
        student = Student(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mediaURL: mediaURL)
        
        // get location data
        let latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double ?? 0.0
        let longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double ?? 0.0
        let mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? ParseClient.DefaultValues.MapString
        location = Location(latitude: latitude, longitude: longitude, mapString: mapString)
    }
    
    init(student: Student, location: Location) {
        objectID = ""
        self.student = student
        self.location = location
    }
    
    init(objectID: String, student: Student, location: Location) {
        self.objectID = objectID
        self.student = student
        self.location = location
    }
    
    // MARK: Convenience "Initializers"
    
    static func locationsFromDictionaries(dictionaries: [[String:AnyObject]]) -> [StudentLocation] {
        var studentLocations = [StudentLocation]()
        for studentDictionary in dictionaries {
            studentLocations.append(StudentLocation(dictionary: studentDictionary))
        }
        return studentLocations
    }
}
