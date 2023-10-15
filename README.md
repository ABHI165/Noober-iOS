
# Noober 2.0 - Debugging Library for iOS 🚀

Noober 2.0 is a powerful debugging library designed specifically for iOS. It allows you to track network requests, log custom events, and share user properties via deep links. This version is built exclusively for iOS, ensuring seamless integration and debugging capabilities for your iOS projects. ![](https://img.shields.io/badge/iOS-black.svg?style=for-the-badge&logo=apple)

> [!WARNING]  
> Noober is designed for debugging purposes only. Make sure to use `#if DEBUG` when using Noober APIs in your production code.

## Table of Contents
- [🚀 Noober 2.0 - Debugging Library for iOS](#-noober-20---debugging-library-for-ios)
- [🔍 Features](#-features)
- [🖇 Getting Started](#️-getting-started)
- [🚀 Initialization](#-initialization)
- [⚙️ Additional Setup](#️-additional-setup)
- [🛠️ Utilizing Additional Features](#️-utilizing-additional-features)
- [📜 License](#-license)


## 🔍 Features


- 🌐 Network Request Tracking: Noober 2.0 provides detailed information about all network requests made from your iOS app, including their responses. You can also share this information with others for debugging purposes.

- 📝 Custom Logs: Easily add custom logs to display important data during debugging, such as analytics events fired within your app.

- 🌐 Change Base URL: Easily switch between different base URLs for network calls during debugging, streamlining testing in various environments.

- 🔗 Share User Defaults via Deep Link: Share user properties stored in UserDefaults with your teammates via deep links. This is especially useful for debugging and switching accounts without going through the authentication process repeatedly.

- 📊 Show and Edit Saved User Defaults: Noober allows you to view and edit saved user properties without the need for additional customization.
  
- 📟 Built-In UI: Noober comes with its own user interface, making debugging a breeze. The user-friendly interface simplifies the process of tracking network requests, viewing custom logs, and managing user properties.


## 🖇 Getting Started

To integrate Noober 2.0 into your iOS project, follow these steps:

Step 1: In Xcode, go to File > Add Package Dependency.

Step 2: Enter the repository URL for Noober 2.0.

That's it! Noober 2.0 will be added to your iOS project, allowing you to enjoy the benefits of iOS-specific debugging.

> [!NOTE]  
> [Check out](https://github.com/ABHI165/Noober-2.0/) the Noober library, built with Kotlin Multiplatform (KMM) to provide cross-platform functionality for both Android and iOS native projects. While the library itself is written in KMM, it's designed to be seamlessly integrated into both Android and iOS applications for debugging purposes. I am also actively working on developing a native Android version of Noober, so stay tuned for updates!


    
## 🚀 Initialization


In your AppDelegate:

```swift
Noober.shared.start()
```
After starting Noober, you can conveniently open and close it by simply shaking your phone.


## ⚙️ Additional Setup

To handle deep links on iOS, follow these steps:

Step 1: Open Xcode and go to Project Settings -> Info.

Step 2: Add a URL Scheme with the value "noober."

Step 3: Call `Noober.shared.handleNoobLink(url: URL)`
 from your SceneDelegate (or App Delegate if you don't have SceneDelegate).

## 🛠️ Utilizing Additional Features
- To add logs, use:
```kotlin
Noober.shared.log(tag: String, value: Any, isError: Boolean = false)

```

- To set user properties for sharing via deep link:
```kotlin
Noober.shared.setShareableNoobProperties(["propertyKey"])
```
Alternatively, you can also use the UserProperties struct to set shareable user properties:

```swift
Noober.shared.setShareableNoobProperties([UserProperties(key: "propertyKey", alternateKey: "crossPlatformKey")])
```

`UserProperties` is a struct containing two keys:

1. `key`: This is the identifier Noober uses to retrieve a specific data value (e.g., an authentication token) from shared preferences (Android) or UserDefaults (iOS).

2. `alternateKey` (Optional): In cases where the same data has different key names on Android and iOS, this attribute helps Noober map the keys correctly when sharing and receiving data via deep links.

## 📽️ Demo


https://github.com/ABHI165/Noober-iOS/assets/56068132/a134b274-a4fc-4a7b-b52a-f61783e41453





## 📜 License

```

  Copyright 2023 ABHI165

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   ```
