//
//  MBHUD.h
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//
/*
 注：当 onView 的参数是 nil ，则添加到 window 上。
 但是当当前的 ViewController 是 mainWindow 的 rootViewController 时， 在viewDidLoad 方法不能是 nil , 因为当前的 ViewController 还没添加到window上，他会把 MBHUD 盖住
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBHUD : NSObject

/**
 创建显示 MBHUD

 @param view superView 添加 HUD 的View
 @return MBHUD
 */
+ (MBHUD *)showHUDToView:(UIView *)view;

/**
 为 backgroundView 添加模糊效果, 默认值 MBProgressHUDBackgroundStyleSolidColor，
 */
- (void)setMBBackgroundStyleBlur;

/**
 为 backgroundView 设置颜色。需要模糊效果需需调用 setMBBackgroundStyleBlur

 @param color UIColor
 */
- (void)setMBBackgroundViewColor:(UIColor *)color;

/**
 为 bezelView 去掉模糊效果, 默认值 MBProgressHUDBackgroundStyleBlur
 */
- (void)setBezelViewStyleSolidColor;

/**
 为 bezelView 设置颜色，默认自带模糊效果，不需要需调用 setBezelViewStyleSolidColor

 @param color UIColor
 */
- (void)setBezelViewColor:(UIColor *)color;

/**
 设置显示内容的颜色

 @param color UIColor
 */
- (void)setContentColor:(UIColor *)color;

/**
 设置 HUD 内容边距

 @param margin margin
 */
- (void)setMargin:(CGFloat)margin;

/**
 设置 HUD 最小尺寸

 @param minSize minSize
 */
- (void)setMInSize:(CGSize)minSize;

/**
 让SuperView响应操作，即禁用HUD的 userInteractionEnabled = NO
 */
- (void)setSuperViewEnabled;

/**
 设置为 dark 显示样式
 */
- (void)setDarkStyle;

/**
 显示文字在屏幕中间，自动消失

 @param text title
 */
- (void)showText:(NSString *)text;

/**
 显示文字在底部，自动消失

 @param text text title
 */
- (void)showTextInBottom:(NSString *)text;

/**
 显示设置好的成功图片，自动消失

 @param title title
 */
- (void)showSuccess:(NSString *)title;

/**
 显示设置好的错误图片，自动消失

 @param title title
 */
- (void)showFailed:(NSString *)title;
/**
 显示设置好的警示图片，自动消失

 @param title title
 */
- (void)showWarning:(NSString *)title;

/**
 显示设置好的自定义的图片，自动消失

 @param img img
 @param title title
 */
- (void)showImage:(UIImage *)img title:(NSString *)title;

/**
 显示 UIActivityIndicatorView StyleWhiteLarge 的等待动画，需手动消失

 @param title title
 */
- (void)showLoading:(NSString *)title;

/**
 显示 UIActivityIndicatorView StyleWhite 的等待动画，需手动消失

 @param title title
 */
- (void)showLoadingSmall:(NSString *)title;

/**
 显示 预设的圆形等待动画，需手动消失

 @param title title
 */
- (void)showLoadingCircle:(NSString *)title;
/**
 显示 预设的旋转等待动画，需手动消失

 @param title title
 */
- (void)showLoadingChaseR:(NSString *)title;

/**
 显示 自定义的 帧动画，需手动消失

 @param imagArray 动画图片数组
 */
- (void)showFrameAnimationWithImageArray:(NSArray *)imagArray;

/**
 显示自定义的 view，需手动消失，(view 上可写动画)

 @param customView 自定义view
 */
- (void)showCustomView:(UIView *)customView;

/**
 手动隐藏方法
 */
- (void)hide;


/**
 显示加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 */
- (void)showDeterminate:(NSString *)title;

/**
 显示 AnnularDeterminate 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 */
- (void)showAnnularDeterminate:(NSString *)title;

/**
 显示 DeterminateHorizontalBar 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 */
- (void)showBarDeterminate:(NSString *)title;

/**
 设置进度的值，在显示加载进度时的进度回调方法中使用

 @param progress 进度值
 */
- (void)setHUDDeterminateProgress:(float)progress;

/**
 当前显示的 window

 @return window
 */
+ (UIWindow *)mainWindow;

@end

