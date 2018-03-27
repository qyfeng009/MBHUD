# MBHUD

![Pod Version](https://img.shields.io/cocoapods/v/MBHUD.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/MBHUD.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/MBHUD.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`MBHUD` is a clean and easy-to-use HUD meant to display the progress of an ongoing task on iOS. 
`MBHUD` depends on the `MBProgressHUD`, it is standing on the shoulders of giants, simple encapsulation of MBProgressHUD. 
 In this to pay tribute to the MBProgressHUD.

![MBHUD](https://github.com/qyfeng009/MBHUD/blob/master/MBHUD.gif)

## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `MBHUD` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'MBHUD'
```
If you want to use the latest features of `MBHUD` use normal external source dependencies.

```ruby
pod 'MBHUD', :git => 'https://github.com/qyfeng009/MBHUD.git'
```

This pulls from the `master` branch directly.

Second, install `MBHUD` into your project:

```ruby
pod install
```

## Swift

Even though `MBHUD` is written in Objective-C, it can be used in Swift with no hassle. If you use [CocoaPods](http://cocoapods.org) add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
use_frameworks!
```
If you added `MBHUD` manually, just add a [bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) file to your project with the `MBHUD` header included. 
## Usage

(see sample Xcode project in `/Demo`)

**Use `MBHUD` wisely! Only use it if you absolutely need to perform a task before taking the user forward. Bad use case examples: pull to refresh, infinite scrolling, sending message.**

Using `MBHUD` in your app will usually look as simple as this (using Grand Central Dispatch):
```objective-c
MBHUD *hud = [[MBHUD alloc] initWithSuperView:self.view];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // time-consuming task
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hid];
    });
});
```
## Customization

`MBHUD` can be customized via the following methods:

```objective-c
/**
 设置 MBProgressHUDBackgroundStyle 为 Blur
 */
- (void)setHUDBackgroundStyleBlur;

/**
 设置 MBBackgroundView 的 color

 @param color UIColor
 */
- (void)setHUDBackgroundViewColor:(UIColor *)color;

/**
 设置 BezelView 的颜色

 @param color UIColor
 */
- (void)setHUDBezelViewColor:(UIColor *)color;

/**
 设置显示内容的颜色

 @param color UIColor
 */
- (void)setHUDContentColor:(UIColor *)color;

/**
 设置 HUD 内容边距

 @param margin margin
 */
- (void)setHUDMargin:(CGFloat)margin;

/**
 设置 HUD 最小尺寸

 @param minSize minSize
 */
- (void)setHUDMInSize:(CGSize)minSize;

/**
 让SuperView响应操作，即禁用HUD的 userInteractionEnabled = NO
 */
- (void)superViewUserInteractionEnabled;

```
## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).


