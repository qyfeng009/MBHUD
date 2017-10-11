//
//  QAnimationSuccess.h
//  ActivityIndicatorAnimation
//
//  Created by 009 on 2017/8/8.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface QAnimationSuccess : UIView
typedef NS_ENUM(NSInteger, QAnimationType) {
    QAnimationTypeSuccess,
    QAnimationTypeError,
};
@property(nonatomic, assign) QAnimationType animationType;
@end
NS_ASSUME_NONNULL_END
