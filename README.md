# GlitchLabel
![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/GlitchLabel.svg?style=flat)](http://cocoapods.org/pods/glitchlabel)
[![License](https://img.shields.io/cocoapods/l/GlitchLabel.svg?style=flat)](http://cocoapods.org/pods/glitchlabel)
[![Platform](https://img.shields.io/cocoapods/p/GlitchLabel.svg?style=flat)](http://cocoapods.org/pods/glitchlabel)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/kciter/GlitchLabel.svg?branch=master)](https://travis-ci.org/kciter/GlitchLabel)

## Preview
<img src="https://github.com/kciter/GlitchLabel/raw/master/Images/preview.gif" alt="Preview gif">
```
$ pod try GlitchLabel
```

## Requirements
* iOS 7.0+
* Swift 2.2
* Xcode 7

## Installation
* CocoaPods
 ```ruby
 use_frameworks!
 pod "GlitchLabel"
 ```

* Carthage
 ```ruby
 github "kciter/GlitchLabel"
 ```

* Swift Package Manager
 ```swift
 import PackageDescription
  
 let package = Package(
   name: "App",
   dependencies: [
     .Package(url: "https://github.com/kciter/GlitchLabel.git", majorVersion: 1)
   ]
 )
 ```

### Manually
To install manually the GlitchLabel in an app, just drag the `GlitchLabel/GlitchLabel.swift` file into your project.

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
