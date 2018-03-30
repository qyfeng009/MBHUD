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
@property (strong, nonatomic) UIImage *circleLoadingImage;
@property (strong, nonatomic) UIImage *chaseRLoadingImage;
@property (strong, nonatomic) UIImage *warningImage;
@property (strong, nonatomic) UIImage *successImage;
@property (strong, nonatomic) UIImage *errorImage;
@end

@implementation MBHUD
#define kMBHUD [MBHUD share]
#define kHUD kMBHUD.hud

+ (instancetype)share {
    static MBHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[MBHUD alloc] init];
    });
    return hud;
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
        UIImage *chaseRLoadingImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"chase_r_loading" ofType:@"png"]];

        _circleLoadingImage = [circleLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _warningImage = [warningImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _successImage = [successImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _errorImage = [errorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _chaseRLoadingImage = [chaseRLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

#pragma mark: - 信息提示（显示后会自定消失，不需要操作 HUD）

+ (void)showHUDOnView:(UIView *)view {
    if ((kHUD && kHUD.superview != view) || !kHUD) {
        if (!view) {
            view = [self mainWindow];
        }
        kHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [kHUD setRemoveFromSuperViewOnHide:YES];
        kHUD.animationType = MBProgressHUDAnimationZoomOut;
        [self setSuperViewUserInteractionEnabled];
    }
}

+ (void)setHUDBackgroundStyleBlur {
    kHUD.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
}
+ (void)setHUDBackgroundViewColor:(UIColor *)color {
    kHUD.backgroundView.color = color;
}
+ (void)setHUDBezelViewColor:(UIColor *)color {
    kHUD.bezelView.color = color;
}
+ (void)setHUDContentColor:(UIColor *)color {
    kHUD.contentColor = color;
}
+ (void)setHUDMargin:(CGFloat)margin {
    [kHUD setMargin:margin];
}
+ (void)setHUDMInSize:(CGSize)minSize {
    kHUD.minSize = minSize;
}
+ (void)setSuperViewUserInteractionEnabled {
    kHUD.userInteractionEnabled = NO;
}

+ (void)setTextStyle:(NSString *)text {
    kHUD.label.text = text;
    kHUD.label.numberOfLines = 0;
}
+ (void)showText:(NSString *)text onView:(UIView *)view {
    [self showHUDOnView:view];
    kHUD.minSize = CGSizeZero;
    [kHUD setMargin:15];
    kHUD.mode = MBProgressHUDModeText;
    [self setSuperViewUserInteractionEnabled];
    [self setTextStyle:text];
    [self hideAfterDelay:[self displayDurationForString:text]];
}
+ (void)showTextInBottom:(NSString *)text onView:(UIView *)view {
    [self showHUDOnView:view];
    kHUD.minSize = CGSizeZero;
    [kHUD setMargin:15];
    kHUD.mode = MBProgressHUDModeText;
    [self setTextStyle:text];
    kHUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [self setSuperViewUserInteractionEnabled];
    [self hideAfterDelay:[self displayDurationForString:text]];
}

+ (void)showImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view {
    [self showHUDOnView:view];
    kHUD.minSize = kHUD.bezelView.bounds.size;
    if (kHUD.minSize.width == 0) {
        kHUD.minSize = CGSizeMake(115, 0);
    }
    kHUD.mode = MBProgressHUDModeCustomView;
    [self setTextStyle:title];
    kHUD.customView = [[UIImageView alloc] initWithImage:img];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
+ (void)showSuccess:(NSString *)title onView:(UIView *)view {
    [self showImage: kMBHUD.successImage title:title onView:view];
}
+ (void)showFailed:(NSString *)title onView:(UIView *)view {
    [self showImage: kMBHUD.errorImage title:title onView:view];
}
+ (void)showWarning:(NSString *)title onView:(UIView *)view {
    [self showImage: kMBHUD.warningImage title:title onView:view];
}

+ (void)hideAfterDelay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [kHUD hideAnimated:YES afterDelay:delay];
        kHUD = nil;
    });
}
+ (NSTimeInterval)displayDurationForString:(NSString *)string {
    return MAX((CGFloat)string.length * 0.06 + 0.5, 2.0f);
}



#pragma mark: - 进度指示（显示后需要主动消失，需要操作 HUD）

+ (MBHUD *)generalMBHUD:(NSString *)title onView:(UIView *)view  {
    MBHUD *mbHud = [[MBHUD alloc] init];
    mbHud.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [mbHud.hud setRemoveFromSuperViewOnHide:YES];
    mbHud.hud.animationType = MBProgressHUDAnimationFade;
    mbHud.hud.label.text = title;
    mbHud.hud.label.numberOfLines = 0;
    mbHud.hud.userInteractionEnabled = NO;
    mbHud.hud.minSize = CGSizeMake(115, 0);
    if (!kHUD) {
        kHUD = mbHud.hud;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [kHUD hideAnimated:YES afterDelay:0];
            kHUD = nil;
        });
    }
    kHUD = mbHud.hud;

    return mbHud;
}
+ (instancetype)showLoading:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeIndeterminate;
    return mbHud;
}
+ (instancetype)showLoadingSmall:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeCustomView;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    mbHud.hud.customView = activityIndicatorView;
    [activityIndicatorView startAnimating];
    return mbHud;
}
+ (instancetype)showLoadingCircle:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeCustomView;
    mbHud.hud.customView = [self getCircleLoadingImageView];
    return mbHud;
}
+ (UIImageView *)getCircleLoadingImageView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: kMBHUD.chaseRLoadingImage];
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
+ (instancetype)showFrameAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view {
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imagArray;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imagArray.count + 1) * 0.072];
    [showImageView startAnimating];
    
    MBHUD *mbHud = [self generalMBHUD:nil onView:view];
    mbHud.hud.mode = MBProgressHUDModeCustomView;
    [mbHud.hud setMargin:0];
    mbHud.hud.bezelView.color = [UIColor clearColor];
    mbHud.hud.customView = showImageView;
    return mbHud;
}
+ (instancetype)showCustomView:(UIView *)customView onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:nil onView:view];
    mbHud.hud.mode = MBProgressHUDModeCustomView;
    mbHud.hud.customView = nil;
    [mbHud.hud setMargin:0];
    mbHud.hud.minSize = customView.bounds.size;
    [mbHud.hud.bezelView addSubview: customView];
    return mbHud;
}
- (void)updateCustomView:(UIView *)customView {
    if (_hud) {
        [self.hud.bezelView addSubview: customView];
    }
}

- (void)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.hud = nil;
    });
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

+ (instancetype)showDeterminate:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeDeterminate;
    return mbHud;
}
+ (instancetype)showAnnularDeterminate:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeAnnularDeterminate;
    return mbHud;
}
+ (instancetype)showBarDeterminate:(NSString *)title onView:(UIView *)view {
    MBHUD *mbHud = [self generalMBHUD:title onView:view];
    mbHud.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    return mbHud;
}
- (void)setHUDDeterminateProgress:(float)progress {
    if (_hud) {
        self.hud.progress = progress;
    }
}

// 获取当前显示的 window
+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}
@end

