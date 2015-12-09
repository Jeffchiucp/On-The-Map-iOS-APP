//
//  APISession.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import Foundation

// MARK: - HTTPMethod Enum

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - APIData

struct APIData {
    let scheme: String
    let host: String
    let path: String
    let domain: String
}

// MARK: - APISession

class APISession {
    
    // MARK: Properties
    
    private let session: NSURLSession!
    private let apiData: APIData
    
    // MARK: Initializers
    
    init(apiData: APIData) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        // allow for adjusting of default configuration...
        
        self.session = NSURLSession(configuration: configuration)
        self.apiData = apiData
    }
    
    // MARK: Requests
    
    func makeRequestAtURL(url: NSURL, method: HTTPMethod, headers: [String:String]? = nil, body: [String:AnyObject]? = nil, responseHandler: (NSData?, NSError?) -> Void) {
        
        // create request and set HTTP method
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue

        // add headers
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // add body
        if let body = body {
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())
        }
                
        // create/return task
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            // was there an error?
            if let error = error {
                responseHandler(nil, error)
                return
            }
            
            // did we get a successful 2XX response?
            if let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode < 200 && statusCode > 299 {
                let userInfo = [
                    NSLocalizedDescriptionKey: Errors.UnsuccessfulResponse
                ]
                let error = NSError(domain: Errors.Domain, code: statusCode, userInfo: userInfo)
                responseHandler(nil, error)
                return
            }
            
            responseHandler(data, nil)
        }
        task.resume()
    }
    
    // MARK: URLs
    
    func urlForMethod(method: String?, withPathExtension: String? = nil, parameters: [String:AnyObject]? = nil) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = apiData.scheme
        components.host = apiData.host
        components.path = apiData.path + (method ?? "") + (withPathExtension ?? "")
                
        if let parameters = parameters {
            components.queryItems = [NSURLQueryItem]()
            for (key, value) in parameters {
                let queryItem = NSURLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.URL!
    }
    
    // MARK: Cookies
    
    func cookieForName(name: String) -> NSHTTPCookie? {
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == name {
                return cookie
            }
        }
        return nil
    }
    
    // MARK: Errors
    
    func errorWithStatus(status: Int, description: String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: description]
        return NSError(domain: apiData.domain, code: status, userInfo: userInfo)
    }
}