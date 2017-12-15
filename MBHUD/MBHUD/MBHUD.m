//
//  MBHUD.m
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "MBHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#define MBShare [MBHUD share]
#define HUD MBShare.hud

@interface MBHUD ()
@property (nonatomic,strong) MBProgressHUD *hud;
@property (strong, nonatomic) UIImage *circleLoadingImage;
@property (strong, nonatomic) UIImage *warningImage;
@property (strong, nonatomic) UIImage *successImage;
@property (strong, nonatomic) UIImage *errorImage;
@end

@implementation MBHUD
+ (instancetype)share {
    static MBHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[MBHUD alloc] init];
    });
    return hud;
}
+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle bundleForClass:[MBHUD class]];
        NSURL *url = [bundle URLForResource:@"MBHUD" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];

        UIImage *circleLoadingImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"circle_loading" ofType:@"png"]];
        UIImage *warningImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"warning" ofType:@"png"]];
        UIImage *successImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
        UIImage *errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];

        _circleLoadingImage = [circleLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _warningImage = [warningImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _successImage = [successImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _errorImage = [errorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    }
    return self;
}
- (void)showHUDOnView:(UIView *)view {
    if (!view) {
        view = [MBHUD mainWindow];
    }
    if (!_hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    } else {
        self.hud = [MBProgressHUD HUDForView:view];
        self.hud.minSize = self.hud.bezelView.bounds.size;
    }
    [self.hud setRemoveFromSuperViewOnHide:YES];
    self.hud.animationType = MBProgressHUDAnimationZoom;
}
+ (void)setHUDBackgroundStyleBlur {
    HUD.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
}
+ (void)setHUDBackgroundViewColor:(UIColor *)color {
    HUD.backgroundView.color = color;
}
+ (void)setHUDBezelViewColor:(UIColor *)color {
    HUD.bezelView.color = color;
}
+ (void)setHUDContentColor:(UIColor *)color {
    HUD.contentColor = color;
}
+ (void)setHUDMargin:(CGFloat)margin {
    [HUD setMargin:margin];
}
+ (void)setHUDMInSize:(CGSize)minSize {
    HUD.minSize = minSize;
}

- (void)setTitleStyle:(NSString *)title {
    self.hud.detailsLabel.text = title;
    self.hud.detailsLabel.numberOfLines = 0;
    if (@available(iOS 8.2, *)) {
        self.hud.detailsLabel.font = [UIFont systemFontOfSize:13 weight:0.5];
    } else {
        self.hud.detailsLabel.font = [UIFont systemFontOfSize:13];
    }
    [self.hud setMargin:10];
}
+ (void)showTitle:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeText;
    [MBShare setTitleStyle:title];
    [self hideAfterDelay:[self displayDurationForString:title]];
}


+ (void)showImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    if (HUD.minSize.width == 0) {
        HUD.minSize = CGSizeMake(100, 0);
    }
    HUD.mode = MBProgressHUDModeCustomView;
    [MBShare setTitleStyle:title];
    [HUD setMargin:20];
    HUD.customView = [[UIImageView alloc] initWithImage:img];
}
+ (void)showSuccess:(NSString *)title onView:(UIView *)view {
    [self showImage:[MBHUD share].successImage title:title onView:view];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
+ (void)showError:(NSString *)title onView:(UIView *)view {
    [self showImage:[MBHUD share].errorImage title:title onView:view];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
+ (void)showWarning:(NSString *)title onView:(UIView *)view {
    [self showImage:[MBHUD share].warningImage title:title onView:view];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
+ (void)showCustomImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view {
    [self showImage:img title:title onView:view];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
+ (void)superViewUserInteractionEnabled {
    HUD.userInteractionEnabled = NO;
}

+ (void)showLoading:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    [MBShare setTitleStyle:title];
    [HUD setMargin:20];
}
+ (void)showLoadingSmall:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    [MBShare setTitleStyle:title];
    [HUD setMargin:20];
    [self setHUDBackgroundStyleBlur];
    HUD.bezelView.backgroundColor = [UIColor clearColor];
    HUD.backgroundView.backgroundColor = view.backgroundColor;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    HUD.customView = activityIndicatorView;
    [activityIndicatorView startAnimating];
}
+ (void)showLoadingCircle:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    [MBShare setTitleStyle:title];
    [HUD setMargin:20];
    HUD.customView = [self getCircleLoadingImageView];
}
+ (UIImageView *)getCircleLoadingImageView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[MBHUD share].circleLoadingImage];
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.18;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [imgView.layer addAnimation:animation forKey:@"rotate360"];
    return imgView;
}
+ (void)showCustomAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view {
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imagArray;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imagArray.count + 1) * 0.072];
    [showImageView startAnimating];
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD setMargin:0];
    HUD.bezelView.color = [UIColor clearColor];
    HUD.customView = showImageView;
}
+ (void)showCustomView:(UIView *)customView onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = nil;
    [HUD setMargin:0];
    HUD.minSize = customView.bounds.size;
    [HUD.bezelView addSubview: customView];
}

+ (void)hide {
    [HUD hideAnimated:YES];
    HUD = nil;
}
+ (void)hideAfterDelay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}
+ (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MAX((CGFloat)string.length * 0.06 + 0.5, 2.0f);
}

+ (void)showDeterminate:(NSString *)title onView:(UIView *)view {
    [MBShare showHUDOnView:view];
    [MBShare setTitleStyle:title];
    [HUD setMargin:20];
    HUD.mode = MBProgressHUDModeDeterminate;
}
+ (void)showAnnularDeterminate:(NSString *)title onView:(UIView *)view {
    [self showDeterminate:title onView:view];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
}
+ (void)showDeterminateHorizontalBar:(NSString *)title onView:(UIView *)view {
    [self showDeterminate:title onView:view];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
}

+ (void)setHUDDeterminateProgress:(float)progress {
    HUD.progress = progress;
}

@end
