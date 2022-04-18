# Movies

Swift Assessment Test 

## Building And Running The Project (Requirements)
* Swift 5.0+
* Xcode 11.5+
* iOS 11.0+

# Getting Started
- If this is your first time encountering swift/ios development, please follow [the instructions](https://developer.apple.com/support/xcode/) to setup Xcode and Swift on your Mac.


## Setup Configs
- Checkout main branch to run latest version
- Open the project by double clicking the `Movies.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app

```
// App Settings
APP_NAME = Movies
PRODUCT_BUNDLE_IDENTIFIER = com.Movies

#targets:
* Movies

```

# Build and or run application by doing:
* Select the build scheme which can be found right after the stop button on the top left of the IDE
* [Command(cmd)] + B - Build app
* [Command(cmd)] + R - Run app

## Architecture
This application uses the Model-View-ViewModel (refereed to as MVVM) UI architecture,


## Structure

### Modules
- Include 
	*MovieDetails/, 
	*MoviesList/.

### Coordinators
- Include AppCoordinator

### Protocol
- Include MovieLoader, loadImage, Coordinator

### Common
- Include Constants, Network+Error,  ImageCache , ImageLoader, MoviePosterSize, Observable

### Extensions
- Include UITableView+Cell,  String+Path , UIView+Constraints,  UIViewController+Error

### Network
- Include NetworkManager

#### screen shots:

![Search (White) scene](https://github.com/TAyes/Movies/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-04-18%20at%2018.04.59.png)
![Results (White) scene](https://github.com/TAyes/Movies/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-04-18%20at%2018.09.50.png)

![Search (dark) scene](https://github.com/TAyes/Movies/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-04-18%20at%2018.02.50.png)
![Results (dark) scene](https://github.com/TAyes/Movies/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-04-18%20at%2018.03.31.png)
