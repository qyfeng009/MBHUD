//
//  MBHUD+Add.h
//  MBHUD
//
//  Created by 009 on 2018/4/3.
//  Copyright © 2018年 qyfeng. All rights reserved.
//

#import "MBHUD.h"

@interface MBHUD (Add)

+ (void)showSuccess:(NSString *)title onView:(UIView *)view;
+ (void)showFailed:(NSString *)title onView:(UIView *)view;
+ (void)showWarning:(NSString *)title onView:(UIView *)view;
+ (void)showImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view;

+ (void)showLoading:(NSString *)text onView:(UIView *)view;
+ (void)showLoadingSmall:(NSString *)title onView:(UIView *)view;
+ (void)showLoadingCircle:(NSString *)title onView:(UIView *)view;
+ (void)showLoadingChaseR:(NSString *)title onView:(UIView *)view;
+ (void)showFrameAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view;
+ (void)showCustomView:(UIView *)customView onView:(UIView *)view;

+ (void)hideOnView:(UIView *)view;
@end
