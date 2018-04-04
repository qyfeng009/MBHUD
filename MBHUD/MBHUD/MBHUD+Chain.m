//
//  MBHUD+Chain.m
//  MBHUD
//
//  Created by 009 on 2018/4/3.
//  Copyright © 2018年 qyfeng. All rights reserved.
//

#import "MBHUD+Chain.h"

@implementation MBHUD (Chain)
- (MBHUD *(^)(void))setBgvBlur {
    return ^id() {
        [self setMBBackgroundStyleBlur];
        return self;
    };
}
- (MBHUD *(^)(UIColor *color))setBgvColor {
    return ^id(UIColor *color) {
        [self setMBBackgroundViewColor:color];
        return self;
    };
}
- (MBHUD *(^)(void))setBezelViewSolidColor {
    return ^id() {
        [self setBezelViewStyleSolidColor];
        return self;
    };
}
- (MBHUD *(^)(UIColor *color))setBezelViewColor {
    return ^id(UIColor *color) {
        [self setBezelViewColor:color];
        return self;
    };
}
- (MBHUD *(^)(UIColor *color))setContentColor {
    return ^id(UIColor *color) {
        [self setContentColor:color];
        return self;
    };
}
- (MBHUD *(^)(CGFloat margin))setMargin {
    return ^id(CGFloat margin) {
        [self setMargin:margin];
        return self;
    };
}
- (MBHUD *(^)(CGSize minSize))setMInSize {
    return ^id(CGSize minSize) {
        [self setMInSize:minSize];
        return self;
    };
}
- (MBHUD *(^)(void))setEnabled {
    return ^id() {
        [self setSuperViewEnabled];
        return self;
    };
}
- (MBHUD *(^)(void))setDark {
    return ^id() {
        [self setDarkStyle];
        return self;
    };
}

- (MBHUD *(^)(NSString *text))showText {
    return ^id(NSString *text) {
        [self showText:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showTextInBottom {
    return ^id(NSString *text) {
        [self showTextInBottom:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showSuccess {
    return ^id(NSString *text) {
        [self showSuccess:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showFailed {
    return ^id(NSString *text) {
        [self showFailed:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showWarning {
    return ^id(NSString *text) {
        [self showWarning:text];
        return self;
    };
}
- (MBHUD *(^)(UIImage *img, NSString *text))showImage {
    return ^id(UIImage *img, NSString *text) {
        [self showImage:img title:text];
        return self;
    };
}

- (MBHUD *(^)(NSString *text))showLoading {
    return ^id(NSString *text) {
        [self showLoading:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showLoadingSmall {
    return ^id(NSString *text) {
        [self showLoadingSmall:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showLoadingCircle {
    return ^id(NSString *text) {
        [self showLoadingCircle:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showLoadingChaseR {
    return ^id(NSString *text) {
        [self showLoadingChaseR:text];
        return self;
    };
}
- (MBHUD *(^)(NSArray *imagArray))showFrameAnimationWithImageArray {
    return ^id(NSArray *imgs) {
        [self showFrameAnimationWithImageArray:imgs];
        return self;
    };
}
- (MBHUD *(^)(UIView *customView))showCustomView {
    return ^id(UIView *customView) {
        [self showCustomView:customView];
        return self;
    };
}

- (MBHUD *(^)(NSString *text))showDeterminate {
    return ^id(NSString *text) {
        [self showDeterminate:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showAnnularDeterminate {
    return ^id(NSString *text) {
        [self showAnnularDeterminate:text];
        return self;
    };
}
- (MBHUD *(^)(NSString *text))showBarDeterminate {
    return ^id(NSString *text) {
        [self showBarDeterminate:text];
        return self;
    };
}
@end
