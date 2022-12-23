<div align="center">
  <img src="https://github.com/kciter/GlitchLabel/raw/master/Images/preview.gif" alt="Preview gif">
</div>
<h1></h1>
<div align="center">
<p><a href="https://camo.githubusercontent.com/0188e770bbde9d9eae6720a70d5d3fad0952d77b/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d322e322d6f72616e67652e737667" target="_blank"><img src="https://img.shields.io/badge/Swift-5-orange.svg"></a>
<a href="http://cocoapods.org/pods/glitchlabel"><img src="https://img.shields.io/cocoapods/v/GlitchLabel.svg?style=flat"></a>
<a href="http://cocoapods.org/pods/glitchlabel"><img alt="License" src="https://img.shields.io/cocoapods/l/GlitchLabel.svg?style=flat"></a>
<a href="http://cocoapods.org/pods/glitchlabel"><img alt="Platform" src="https://img.shields.io/cocoapods/p/GlitchLabel.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="https://travis-ci.org/kciter/GlitchLabel"><img alt="Build Status" src="https://travis-ci.org/kciter/GlitchLabel.svg?branch=master"></a></p>
</div>

<div align="center">
  Glitching UILabel for iOS 📺<br>
</div>
<div align="center">
  <sub>Created by <a href="https://github.com/kciter">Lee Sun-Hyoup</a>.</sub>
</div>

## Try the sample
```
$ pod try GlitchLabel
```

## Requirements
* iOS 8.0+
* Swift 3
* Xcode 8

## Installation
* **CocoaPods**
  ```ruby
  use_frameworks!
  pod "GlitchLabel", "~> 2.0.0"
  ```

* **Carthage**
  ```ruby
  github "kciter/GlitchLabel"
  ```

* **Swift Package Manager**
  ```swift
  import PackageDescription

  let package = Package(
    name: "App",
    dependencies: [
      .Package(url: "https://github.com/kciter/GlitchLabel.git", majorVersion: 2)
    ]
  )
  ```

* **Manually**
  * To install the GlitchLabel manually in an app, just drag the `GlitchLabel/GlitchLabel.swift` file into your project.

## Usage

### Storyboard support
<img src="https://github.com/kciter/GlitchLabel/raw/master/Images/storyboard.png" height='300' alt="Storyboard support">

### Programmatically
```swift
let glitchLabel = GlitchLabel()
glitchLabel.text = "Hello, World!"
// ... Change font
glitchLabel.sizeToFit()
// ... Change offset
view.addSubview(glitchLabel)
```

### White screen
```swift
glitchLabel.blendMode = .Multiply
```
<img src="https://github.com/kciter/GlitchLabel/raw/master/Images/whitescreen.gif" alt="White screen">

## Inspired
* http://codepen.io/paultreny/pen/nJyvG

## Donate
If you like this open source, you can sponsor it. :smile:

[Paypal me](paypal.me/kciter)

## License
The MIT License (MIT)

Copyright (c) 2016 Lee Sun-Hyoup

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
