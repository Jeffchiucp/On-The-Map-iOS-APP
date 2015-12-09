//
//  Location.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import MapKit

// MARK: - Location

struct Location {
    
    // MARK: Properties
    
    let latitude: Double
    let longitude: Double
    let mapString: String
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
}