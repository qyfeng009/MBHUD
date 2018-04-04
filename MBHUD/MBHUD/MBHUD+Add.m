//
//  MBHUD+Add.m
//  MBHUD
//
//  Created by 009 on 2018/4/3.
//  Copyright © 2018年 qyfeng. All rights reserved.
//

#import "MBHUD+Add.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBHUD+Chain.h"

@implementation MBHUD (Add)

+ (MBHUD *)creatHUDToView:(UIView *)view {
    if (!view) {
        view = [self mainWindow];
    }
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *mb = (MBProgressHUD *)v;
            mb.animationType = MBProgressHUDAnimationFade;
            [mb hideAnimated:YES];
        }
    }
    MBHUD *HUD = [MBHUD showHUDToView:view];
    return HUD;
}

+ (void)showText:(NSString *)text onView:(UIView *)view {
    [self creatHUDToView:view].showText(text);
}
+ (void)showTextInBottom:(NSString *)text onView:(UIView *)view {
    [self creatHUDToView:view].showTextInBottom(text);
}

+ (void)showSuccess:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showSuccess(title);
}
+ (void)showFailed:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showFailed(title);
}
+ (void)showWarning:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showWarning(title);
}
+ (void)showImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showImage(img, title);
}


+ (void)showLoading:(NSString *)text onView:(UIView *)view {
    [self creatHUDToView:view].showLoading(text);
}
+ (void)showLoadingSmall:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showLoadingSmall(title);
}
+ (void)showLoadingCircle:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showLoadingCircle(title);
}
+ (void)showLoadingChaseR:(NSString *)title onView:(UIView *)view {
    [self creatHUDToView:view].showLoadingChaseR(title);
}
+ (void)showFrameAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view {
    [self creatHUDToView: view].showFrameAnimationWithImageArray(imagArray);
}
+ (void)showCustomView:(UIView *)customView onView:(UIView *)view {
    [self creatHUDToView:view].showCustomView(customView);
}


+ (void)hideOnView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}
@end
