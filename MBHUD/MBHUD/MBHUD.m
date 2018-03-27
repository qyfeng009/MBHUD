//
//  MBHUD.m
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "MBHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBHUD ()
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *superView;
@property (strong, nonatomic) UIImage *circleLoadingImage;
@property (strong, nonatomic) UIImage *warningImage;
@property (strong, nonatomic) UIImage *successImage;
@property (strong, nonatomic) UIImage *errorImage;
@end

@implementation MBHUD

- (instancetype)initWithSuperView:(UIView *)view {
    self = [super init];
    if (self) {
        self.superView = view;
        NSBundle *bundle = [NSBundle bundleForClass:[MBHUD class]];
        NSURL *url = [bundle URLForResource:@"MBHUD" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        UIImage *circleLoadingImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"circle_loading" ofType:@"png"]];
        UIImage *warningImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"warning" ofType:@"png"]];
        UIImage *successImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
        UIImage *errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
        
        self.circleLoadingImage = [circleLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.warningImage = [warningImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.successImage = [successImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.errorImage = [errorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        if (!view) {
            view = [self mainWindow];
        }
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self.hud setRemoveFromSuperViewOnHide:YES];
        self.hud.animationType = MBProgressHUDAnimationZoom;
    }
    return self;
}

- (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}

- (void)setHUDBackgroundStyleBlur {
    self.hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
}
- (void)setHUDBackgroundViewColor:(UIColor *)color {
    self.hud.backgroundView.color = color;
}
- (void)setHUDBezelViewColor:(UIColor *)color {
    self.hud.bezelView.color = color;
}
- (void)setHUDContentColor:(UIColor *)color {
    self.hud.contentColor = color;
}
- (void)setHUDMargin:(CGFloat)margin {
    [self.hud setMargin:margin];
}
- (void)setHUDMInSize:(CGSize)minSize {
    self.hud.minSize = minSize;
}

- (void)setTextStyle:(NSString *)text {
    self.hud.label.text = text;
    self.hud.label.numberOfLines = 0;
}
- (void)showText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeText;
        [self setTextStyle:text];
        [self hideAfterDelay:[self displayDurationForString:text]];
    });
}
- (void)showTextInBottom:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeText;
        [self setTextStyle:text];
        self.hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        [self hideAfterDelay:[self displayDurationForString:text]];
    });
}

- (void)showImage:(UIImage *)img title:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.minSize = self.hud.bezelView.bounds.size;
        if (self.hud.minSize.width == 0) {
            self.hud.minSize = CGSizeMake(100, 100);
        }
        self.hud.mode = MBProgressHUDModeCustomView;
        [self setTextStyle:title];
        self.hud.customView = [[UIImageView alloc] initWithImage:img];
        [self hideAfterDelay:[self displayDurationForString:title]];
    });
}
- (void)showSuccess:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showImage: _successImage title:title];
    });
}
- (void)showFailed:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showImage: _errorImage title:title];
    });
}
- (void)showWarning:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showImage: _warningImage title:title];
    });
}

- (void)superViewUserInteractionEnabled {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.userInteractionEnabled = NO;
    });
}

- (void)showLoading:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeIndeterminate;
        [self setTextStyle:title];
    });
}
- (void)showLoadingSmall:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeCustomView;
        [self setTextStyle:title];
        [self setHUDBackgroundStyleBlur];
        self.hud.bezelView.backgroundColor = [UIColor clearColor];
        self.hud.backgroundView.backgroundColor = _superView.backgroundColor;
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.hud.customView = activityIndicatorView;
        [activityIndicatorView startAnimating];
    });
}
- (void)showLoadingCircle:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeCustomView;
        [self setTextStyle:title];
        self.hud.customView = [self getCircleLoadingImageView];
    });
}
- (UIImageView *)getCircleLoadingImageView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: _circleLoadingImage];
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
- (void)showFrameAnimationWithImageArray:(NSArray *)imagArray {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *showImageView = [[UIImageView alloc] init];
        showImageView.animationImages = imagArray;
        [showImageView setAnimationRepeatCount:0];
        [showImageView setAnimationDuration:(imagArray.count + 1) * 0.072];
        [showImageView startAnimating];
        
        self.hud.mode = MBProgressHUDModeCustomView;
        [_hud setMargin:0];
        self.hud.bezelView.color = [UIColor clearColor];
        self.hud.customView = showImageView;
    });
}
- (void)showCustomView:(UIView *)customView {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeCustomView;
        self.hud.customView = nil;
        [self.hud setMargin:0];
        self.hud.minSize = customView.bounds.size;
        [self.hud.bezelView addSubview: customView];
    });
}

- (void)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.hud = nil;
    });
}
- (void)hideAfterDelay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES afterDelay:delay];
        self.hud = nil;
    });
}
- (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MAX((CGFloat)string.length * 0.06 + 0.5, 2.0f);
}

- (void)showDeterminate:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTextStyle:title];
        self.hud.mode = MBProgressHUDModeDeterminate;
    });
}
- (void)showAnnularDeterminate:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTextStyle:title];
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    });
}
- (void)showBarDeterminate:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTextStyle:title];
        self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    });
}
- (void)setHUDDeterminateProgress:(float)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.progress = progress;
    });
}

@end
