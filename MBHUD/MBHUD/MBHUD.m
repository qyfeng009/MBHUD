//
//  MBHUD.m
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "MBHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) printf("%s - [Line %d]\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String], __LINE__)
#else
#define NSLog(...)
#endif

@interface MBHUD ()
@property (nonatomic, strong) MBProgressHUD *hud;
@property (strong, nonatomic) UIImage *circleLoadingImage;
@property (strong, nonatomic) UIImage *chaseRLoadingImage;
@property (strong, nonatomic) UIImage *warningImage;
@property (strong, nonatomic) UIImage *successImage;
@property (strong, nonatomic) UIImage *errorImage;
@end

@implementation MBHUD

- (instancetype)initWithSuperView:(UIView *)view {
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

        self.circleLoadingImage = [circleLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.warningImage = [warningImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.successImage = [successImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.errorImage = [errorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.chaseRLoadingImage = [chaseRLoadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self.hud setRemoveFromSuperViewOnHide:YES];
        self.hud.animationType = MBProgressHUDAnimationZoom;
    }
    return self;
}

+ (MBHUD *)showHUDToView:(UIView *)view {
    if (!view) {
        if ([self mainWindow]) {
            view = [self mainWindow];
        } else {
            NSLog(@"当前 window = nil，无法创建 MNHUD");
            return nil;
        }
    }
    return [[MBHUD alloc] initWithSuperView:view];
}
+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}
// 为 backgroundView 添加模糊效果, 默认值 MBProgressHUDBackgroundStyleSolidColor，
- (void)setMBBackgroundStyleBlur {
    self.hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
}
// 为 backgroundView 设置颜色。需要模糊效果需需调用 setMBBackgroundStyleBlur
- (void)setMBBackgroundViewColor:(UIColor *)color {
    self.hud.backgroundView.color = color;
}
// 为 bezelView 去掉模糊效果, 默认值 MBProgressHUDBackgroundStyleBlur，
- (void)setBezelViewStyleSolidColor {
    [self.hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}
// 为 bezelView 设置颜色，默认自带模糊效果，不需要需调用 setBezelViewStyleSolidColor
- (void)setBezelViewColor:(UIColor *)color {
    self.hud.bezelView.color = color;
}
- (void)setContentColor:(UIColor *)color {
    self.hud.contentColor = color;
}
- (void)setMargin:(CGFloat)margin {
    [self.hud setMargin:margin];
}
- (void)setMInSize:(CGSize)minSize {
    self.hud.minSize = minSize;
}
- (void)setSuperViewEnabled {
    self.hud.userInteractionEnabled = NO;
}
- (void)setDarkStyle {
    [self.hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
    [self.hud.bezelView setColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [self setContentColor:[UIColor whiteColor]];
}

- (void)setTextStyle:(NSString *)text {
    self.hud.label.text = text;
    self.hud.label.numberOfLines = 0;
}
- (void)showText:(NSString *)text {
    self.hud.mode = MBProgressHUDModeText;
    [self setTextStyle:text];
    [self hideAfterDelay:[self displayDurationForString:text]];
}
- (void)showTextInBottom:(NSString *)text {
    self.hud.mode = MBProgressHUDModeText;
    self.hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [self setTextStyle:text];
    [self hideAfterDelay:[self displayDurationForString:text]];
}

- (void)showImage:(UIImage *)img title:(NSString *)title {
    self.hud.minSize = self.hud.bezelView.bounds.size;
    if (self.hud.minSize.width == 0) {
        [self setMInSize:CGSizeMake(100, 0)];
    }
    self.hud.mode = MBProgressHUDModeCustomView;
    [self setTextStyle:title];
    self.hud.customView = [[UIImageView alloc] initWithImage:img];
    [self hideAfterDelay:[self displayDurationForString:title]];
}
- (void)showSuccess:(NSString *)title {
    [self showImage: self.successImage title:title];
}
- (void)showFailed:(NSString *)title {
    [self showImage: self.errorImage title:title];
}
- (void)showWarning:(NSString *)title {
    [self showImage: self.warningImage title:title];
}

- (void)showLoading:(NSString *)title {
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self setTextStyle:title];
}
- (void)showLoadingSmall:(NSString *)title {
    self.hud.mode = MBProgressHUDModeCustomView;
    [self setTextStyle:title];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.hud.customView = activityIndicatorView;
    [activityIndicatorView startAnimating];
}
- (void)showLoadingCircle:(NSString *)title {
    self.hud.mode = MBProgressHUDModeCustomView;
    [self setTextStyle:title];
    self.hud.customView = [self getCircleLoadingImageView: self.circleLoadingImage];
}
- (void)showLoadingChaseR:(NSString *)title {
    self.hud.mode = MBProgressHUDModeCustomView;
    [self setTextStyle:title];
    self.hud.customView = [self getCircleLoadingImageView: self.chaseRLoadingImage];
}
- (UIImageView *)getCircleLoadingImageView:(UIImage *)img {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: img];
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
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imagArray;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imagArray.count + 1) * 0.072];
    [showImageView startAnimating];

    self.hud.mode = MBProgressHUDModeCustomView;
    [self.hud setMargin:0];
    self.hud.bezelView.color = [UIColor clearColor];
    self.hud.customView = showImageView;
}
- (void)showCustomView:(UIView *)customView {
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = nil;
    [self.hud setMargin:0];
    self.hud.minSize = customView.bounds.size;
    [self.hud.bezelView addSubview: customView];
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
    return MAX((CGFloat)string.length * 0.10 + 0.5, 2.0f);
}

- (void)showDeterminate:(NSString *)title {
    [self setTextStyle:title];
    self.hud.mode = MBProgressHUDModeDeterminate;
}
- (void)showAnnularDeterminate:(NSString *)title {
    [self setTextStyle:title];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
}
- (void)showBarDeterminate:(NSString *)title {
    [self setTextStyle:title];
    self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
}
- (void)setHUDDeterminateProgress:(float)progress {
    self.hud.progress = progress;
}

@end
