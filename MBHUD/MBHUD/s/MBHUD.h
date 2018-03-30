//
//  MBHUD.h
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//
// 注： 作者在背景图框上加了一层毛玻璃 UIVisualEffectView，如果不需要毛玻璃效果 在MBProgressHUD.m的 1164左右行，注释掉就好了
// 当 onView 的参数是 nil ，则添加到 window 上。
// 但是当当前的 ViewController 是 mainWindow 的 rootViewController 时， 在viewDidLoad 方法不能是 nil , 因为当前的 ViewController 还没添加到window上，他会把 MBHUD 盖住
/*
 类方法分为两个部分
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBHUD : NSObject

/**
 设置 MBProgressHUDBackgroundStyle 为 Blur
 */
+ (void)setHUDBackgroundStyleBlur;

/**
 设置 MBBackgroundView 的 color

 @param color UIColor
 */
+ (void)setHUDBackgroundViewColor:(UIColor *)color;

/**
 设置 BezelView 的颜色

 @param color UIColor
 */
+ (void)setHUDBezelViewColor:(UIColor *)color;

/**
 设置显示内容的颜色

 @param color UIColor
 */
+ (void)setHUDContentColor:(UIColor *)color;

/**
 设置 HUD 内容边距

 @param margin margin
 */
+ (void)setHUDMargin:(CGFloat)margin;

/**
 设置 HUD 最小尺寸

 @param minSize minSize
 */
+ (void)setHUDMInSize:(CGSize)minSize;

/**
 让SuperView响应操作，即禁用HUD的 userInteractionEnabled = NO
 */
+ (void)setSuperViewUserInteractionEnabled;


/**
 显示文字，自动消失

 @param text title
 */
+ (void)showText:(NSString *)text onView:(UIView *)view;

/**
 显示文字在底部，自动消失

 @param text text title
 */
+ (void)showTextInBottom:(NSString *)text onView:(UIView *)view;

/**
 显示设置好的成功图片，自动消失

 @param title title
 */
+ (void)showSuccess:(NSString *)title onView:(UIView *)view;

/**
 显示设置好的错误图片，自动消失

 @param title title
 */
+ (void)showFailed:(NSString *)title onView:(UIView *)view;
/**
 显示设置好的警示图片，自动消失

 @param title title
 */
+ (void)showWarning:(NSString *)title onView:(UIView *)view;

/**
 显示设置好的自定义的图片，自动消失

 @param img img
 @param title title
 */
+ (void)showImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view;





/**
 创建显示 UIActivityIndicatorView StyleWhiteLarge 的等待动画，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showLoading:(NSString *)title onView:(UIView *)view ;

/**
 创建显示 UIActivityIndicatorView StyleWhite 的等待动画，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showLoadingSmall:(NSString *)title onView:(UIView *)view;

/**
 创建圆旋转动画，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showLoadingCircle:(NSString *)title onView:(UIView *)view;

/**
 创建显示帧动画，需手动消失

 @param imagArray 帧动画数组
 @param view superView
 @return MBHUD
 */
+ (instancetype)showFrameAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view;

/**
 创建显示自定义 View，需手动消失

 @param customView customView
 @param view superView
 @return MBHUD
 */
+ (instancetype)showCustomView:(UIView *)customView onView:(UIView *)view;
/**
 更新自定义 View，作为 showCustomView 的方法补充

 @param customView 自定义的 View
 */
- (void)updateCustomView:(UIView *)customView;


/**
 手动隐藏方法，进度指示HUD 独立方法
 */
- (void)hide;

// 配置 MBHUD 的方法
- (void)setHUDBackgroundStyleBlur; ///< 设置 MBProgressHUDBackgroundStyle 为 Blur
- (void)setHUDBackgroundViewColor:(UIColor *)color; ///< 设置 MBBackgroundView 的 color
- (void)setHUDBezelViewColor:(UIColor *)color; ///< 设置 BezelView 的颜色
- (void)setHUDContentColor:(UIColor *)color; ///< 设置显示内容的颜色
- (void)setHUDMargin:(CGFloat)margin; ///< 设置 HUD 内容边距
- (void)setHUDMInSize:(CGSize)minSize; ///< 设置 HUD 最小尺寸

/**
 创建显示加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showDeterminate:(NSString *)title onView:(UIView *)view;

/**
 创建显示 AnnularDeterminate 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showAnnularDeterminate:(NSString *)title onView:(UIView *)view;

/**
 创建显示 DeterminateHorizontalBar 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title title
 @param view superView
 @return MBHUD
 */
+ (instancetype)showBarDeterminate:(NSString *)title onView:(UIView *)view;

/**
 设置进度的值，在显示加载进度时的进度回调方法中使用

 @param progress 进度值
 */
- (void)setHUDDeterminateProgress:(float)progress;
@end
