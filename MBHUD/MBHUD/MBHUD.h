//
//  MBHUD.h
//  MBHUD
//
//  Created by 009 on 2017/10/9.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBHUD : NSObject
+ (instancetype)share;


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
+ (void)superViewUserInteractionEnabled;



/**
 显示文字，自动消失

 @param title title
 @param view superView
 */
+ (void)showTitle:(NSString *)title onView:(UIView *)view;

/**
 显示设置好的成功图片，自动消失

 @param title title
 @param view superView
 */
+ (void)showSuccess:(NSString *)title onView:(UIView *)view;

/**
 显示设置好的错误图片，自动消失

 @param title title
 @param view superView
 */
+ (void)showError:(NSString *)title onView:(UIView *)view;
/**
 显示设置好的警示图片，自动消失

 @param title title
 @param view superView
 */
+ (void)showWarning:(NSString *)title onView:(UIView *)view;

/**
 显示设置好的自定义的图片，自动消失

 @param img img
 @param title title
 @param view superView
 */
+ (void)showCustomImage:(UIImage *)img title:(NSString *)title onView:(UIView *)view;


/**
 显示 UIActivityIndicatorView StyleWhiteLarge 的等待动画，需手动消失

 @param title title
 @param view superView
 */
+ (void)showLoading:(NSString *)title onView:(UIView *)view;

/**
 显示 UIActivityIndicatorView StyleWhite 的等待动画，需手动消失

 @param title title
 @param view superView
 */
+ (void)showLoadingSmall:(NSString *)title onView:(UIView *)view;

/**
 显示 预设的圆形等待动画，需手动消失

 @param title title
 @param view superView
 */
+ (void)showLoadingCircle:(NSString *)title onView:(UIView *)view;


/**
 显示 自定义的 帧动画，需手动消失

 @param imagArray 动画图片数组
 @param view superView
 */
+ (void)showCustomAnimationWithImageArray:(NSArray *)imagArray onView:(UIView *)view;

/**
 显示自定义的 view，需手动消失，(view 上可写动画)

 @param customView 自定义view
 @param view superView
 */
+ (void)showCustomView:(UIView *)customView onView:(UIView *)view;

/**
 手动隐藏方法
 */
+ (void)hide;


/**
 显示加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 @param view superView
 */
+ (void)showDeterminate:(NSString *)title onView:(UIView *)view;

/**
 显示 AnnularDeterminate 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 @param view superView
 */
+ (void)showAnnularDeterminate:(NSString *)title onView:(UIView *)view;

/**
 显示 DeterminateHorizontalBar 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失

 @param title tips
 @param view superView
 */
+ (void)showDeterminateHorizontalBar:(NSString *)title onView:(UIView *)view;

/**
 设置进度的值，在显示加载进度时的进度回调方法中使用

 @param progress 进度值
 */
+ (void)setHUDDeterminateProgress:(float)progress;
@end
