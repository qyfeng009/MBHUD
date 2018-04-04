//
//  MBHUD+Chain.h
//  MBHUD
//
//  Created by 009 on 2018/4/3.
//  Copyright © 2018年 qyfeng. All rights reserved.
//

#import "MBHUD.h"

@interface MBHUD (Chain)
- (MBHUD *(^)(void))setBgvBlur; ///< 为背景添加模糊效果
- (MBHUD *(^)(UIColor *color))setBgvColor; ///< 设置背景颜色
- (MBHUD *(^)(void))setBezelViewSolidColor; ///< 去掉 bezelView 模糊效果
- (MBHUD *(^)(UIColor *color))setBezelViewColor; ///< 为 bezelView 设置颜色，默认自带模糊效果
- (MBHUD *(^)(UIColor *color))setContentColor; ///< 设置显示内容的颜色
- (MBHUD *(^)(CGFloat margin))setMargin; ///< 设置 HUD 内容边距
- (MBHUD *(^)(CGSize minSize))setMInSize; ///< 设置 HUD 最小尺寸
- (MBHUD *(^)(void))setEnabled; ///< 让SuperView响应操作
- (MBHUD *(^)(void))setDark; ///< 设置为 dark 显示样式

- (MBHUD *(^)(NSString *text))showText; ///< 显示文字在屏幕中间，自动消失
- (MBHUD *(^)(NSString *text))showTextInBottom; ///< 显示文字在底部，自动消失
- (MBHUD *(^)(NSString *text))showSuccess; ///< 显示成功，自动消失
- (MBHUD *(^)(NSString *text))showFailed; ///< 显示失败，自动消失
- (MBHUD *(^)(NSString *text))showWarning; ///< 显示警示，自动消失
- (MBHUD *(^)(UIImage *img, NSString *text))showImage; ///< 显示自定义图片，自动消失

- (MBHUD *(^)(NSString *text))showLoading; ///< 显示  大 的 * 的等待动画，需手动消失
- (MBHUD *(^)(NSString *text))showLoadingSmall; ///< 显示  小 的 * 的等待动画，需手动消失
- (MBHUD *(^)(NSString *text))showLoadingCircle; ///< 显示 预设的圆形等待动画，需手动消失
- (MBHUD *(^)(NSString *text))showLoadingChaseR; ///< 显示 预设的旋转等待动画，需手动消失
- (MBHUD *(^)(NSArray *imagArray))showFrameAnimationWithImageArray; // 自定义的帧动画，需手动消失
- (MBHUD *(^)(UIView *customView))showCustomView; ///< 自定义的 view，需手动消失

- (MBHUD *(^)(NSString *text))showDeterminate; ///< 显示加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失
- (MBHUD *(^)(NSString *text))showAnnularDeterminate; ///< 显示 AnnularDeterminate 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失
- (MBHUD *(^)(NSString *text))showBarDeterminate; ///< 显示 DeterminateHorizontalBar 加载进度,需配合 setHUDDeterminateProgress 方法(在获取进度值的方法中调用)，需手动消失
@end
