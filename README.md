# On the Map

[Platform iOS]

This is an implementation of On the Map, the third project in the iOS Developer Nanodegree.

Some issues can be found about Swift 2.0

Use 'UIActivityIndicatorView' to indicate an activity during the geocoding. 
Set the properties such as background color, viewStyle, and so on. If you get location information successfully after geocoding, you can stop it in the completion block.

[Important Note]
it uses Facebook SKD 4.0.1 and for this reason it need the SDK installed at ~/Documents/FacebookSDK/

However, to be able to compile it you have to remove the module maps manually from each of the FBSDK*Kit.framework bundles; e.g., rm -r ~/Documents/FacebookSDK/FBSDKCoreKit.framework/Modules/ (and repeat for FBSDKLoginKit and FBSDKShareKit. More info

Udacity API

This way the value is shown in the string.

request.HTTPBody = "{\"udacity\": {\"username\": \"\(username.text!)\", \"password\": \"\(password.text!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
