# On the Map

[Platform iOS]

This is an implementation of On the Map, the third project in the iOS Developer Nanodegree.

Helpful information [https://docs.google.com/document/d/1MECZgeASBDYrbBg7RlRu9zBBLGd3_kfzsN-0FtURqn0/pub?embedded=true]
• The networking and JSON parsing code is located in a dedicated API client class (and not, for example, inside a view controller). The class uses closures for completion and error handling.
• The networking code uses Swift's built-in NSURLSession library, not a third-party framework.
• The JSON parsing code uses Swift's built-in NSJSONSerialization library, not a third-party framework.

[Important Note]
Some issues can be found about Swift 2.0

it uses Facebook SKD 4.0.1 and for this reason it need the SDK installed at ~/Documents/FacebookSDK/

However, to be able to compile it you have to remove the module maps manually from each of the FBSDK*Kit.framework bundles; e.g., rm -r ~/Documents/FacebookSDK/FBSDKCoreKit.framework/Modules/ (and repeat for FBSDKLoginKit and FBSDKShareKit. More info

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
