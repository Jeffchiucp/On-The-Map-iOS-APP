# On the Map

[Platform iOS]

This is an implementation of On the Map, the third project in Udacity's iOS Developer Nanodegree.

[Important Note]
Some issues can be found about Swift 2.0

Udacity API
https://www.udacity.com/api/session

This way the value is shown in the string.

request.HTTPBody = "{\"udacity\": {\"username\": \"\(username.text!)\", \"password\": \"\(password.text!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)

Parsing JSON instruction
https://docs.google.com/document/d/1E7JIiRxFR3nBiUUzkKal44l9JkSyqNWvQrNH4pDrOFU/pub?embedded=true

Use 'UIActivityIndicatorView' to indicate an activity during the geocoding. 
Set the properties such as background color, viewStyle, and so on. If you get location information successfully after geocoding, you can stop it in the completion block.


Helpful Resources:

http://docs.themoviedb.apiary.io/#reference/authentication/authenticationsessionnew
https://github.com/udacity/ios-networking-2.0
https://docs.google.com/document/d/1MECZgeASBDYrbBg7RlRu9zBBLGd3_kfzsN-0FtURqn0/pub?embedded=true
https://docs.google.com/document/d/1E7JIiRxFR3nBiUUzkKal44l9JkSyqNWvQrNH4pDrOFU/pub?embedded=true
https://www.udacity.com/api/session

• The networking and JSON parsing code is located in a dedicated API client class (and not, for example, inside a view controller). The class uses closures for completion and error handling.
• The networking code uses Swift's built-in NSURLSession library, not a third-party framework.
• The JSON parsing code uses Swift's built-in NSJSONSerialization library, not a third-party framework.

Codes Snippet:

let request = NSMutableURLRequest(URL: url)
request.HTTPMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "Accept")
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.HTTPBody = "{\"media_type\": \"movie\",\"media_id\":550,\"favorite\":true}".dataUsingEncoding(NSUTF8StringEncoding)
