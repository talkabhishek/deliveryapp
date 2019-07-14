## LalaMoveChallenge (mobile)
A project which list deliveries of goods and their delivery details with map location. 

# Requirement & Support
Xcode : 10.2.1
Swift 5
Cocoapods setup on system
iOS (10.x, 11.x, 12.x)

# Installation
To run the project :
- Goto Project Root folder
- pod install
- Open xcworkspace 

# Design  Pattern
## MVVM
- Model: hold application data. They’re usually structs or simple classes.
- View: display visual elements and controls on the screen. They’re typically subclasses of UIView
- ViewModel: transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references

![MVVM_Diagram](https://user-images.githubusercontent.com/26160090/60809569-97827e00-a1a8-11e9-9a5f-e0c557f73cc7.png)

# "Pod Used"      
- SwiftLint
- Alamofire
- SDWebImage
- Firebase/Core'
- Fabric
- Crashlytics

# MapView
- MKMapView map is used.

# Linting
- SwiftLint Library is used for linting

# Data Caching
- CoreData is used for data caching. Every time items fetched from server will save into database as well. Data insertion is done based on "id", new item will be inserted only for a new "id"
- Images are cached with SDWebImage Library
- "Pull to refresh" will fetch data from starting index, and it will clear all previous data stored in local database.

# Firebase "CrashAnalytics"
-  We need to create account on firebase and replace "GoogleService-Info.plist" file with new geenrated plist file which will be geretated while creating an app on firebase.

# Configuration
- Configuration file is added , it will be helpful for different environment and static strings like keys

# Unit Testing
- Unit testing is done by using XCTest.
- To run tests click Product->Test or (cmd+U)

# Assumptions        
-   The app is designed for iPhones only .       
-   App  supports multi languages , but right now only english language text is displaying.
-   Mobile platform supported: iOS (10.x, 11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series. 
-    iPhone app support would be limited to portrait mode.

# Scope for Improvement
- UITesting

# Screenshots
![Simulator Screen Shot - iPhone Xʀ - 2019-07-14 at 12 41 10](https://user-images.githubusercontent.com/26160090/61180492-b5326600-a634-11e9-9cc5-a1c1d92ad153.png)
![Simulator Screen Shot - iPhone Xʀ - 2019-07-14 at 12 41 17](https://user-images.githubusercontent.com/26160090/61180494-b82d5680-a634-11e9-9d57-c55e39ca17a2.png)
