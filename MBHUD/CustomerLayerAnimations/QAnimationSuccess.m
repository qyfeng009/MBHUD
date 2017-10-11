//
//  QAnimationSuccess.m
//  ActivityIndicatorAnimation
//
//  Created by 009 on 2017/8/8.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "QAnimationSuccess.h"

@implementation QAnimationSuccess

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)setAnimationType:(QAnimationType)animationType {
    if (_animationType!= animationType) {
        _animationType = animationType;
    }
    [self drawPathAnimation];
}
- (void)drawPathAnimation {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    CGFloat lineWidth = 2;
    CGFloat circleOutSideSpacing = 2;
    CGFloat circleSize = (self.frame.size.width-circleOutSideSpacing*2)/2 - 8;
    CGFloat circleInSideSpacing = circleSize-circleSize/3*2;
    CFTimeInterval duration = 0.81;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;


    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:circleSize startAngle:M_PI endAngle:M_PI*4 clockwise:YES];

    if (_animationType == QAnimationTypeSuccess) {
        [path moveToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2-circleInSideSpacing/3) angle:180+15 radius:circleSize-lineWidth*2-circleInSideSpacing]];
        [path addLineToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2-circleInSideSpacing/3) angle:180+90-15 radius:circleSize-lineWidth*2-circleInSideSpacing]];
        [path addLineToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2-circleInSideSpacing/3) angle:15 radius:circleSize-lineWidth*2-circleInSideSpacing]];
    } else if (_animationType == QAnimationTypeError) {
        [path moveToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2) angle:180-45 radius:circleSize-lineWidth*2-circleInSideSpacing]];
        [path addLineToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2) angle:180+90+45 radius:circleSize-lineWidth*2-circleInSideSpacing]];
        [path moveToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2) angle:45 radius:circleSize-lineWidth*2-circleInSideSpacing]];
        [path addLineToPoint:[self calcCircleCoordinateWithCenter:CGPointMake(width/2, height/2) angle:180+45 radius:circleSize-lineWidth*2-circleInSideSpacing]];
    }


    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = nil;
    layer.lineWidth = lineWidth;
    layer.lineCap = @"round";
    layer.lineJoin = @"round";
    layer.strokeStart = 0.0;
    layer.strokeEnd = 0.0;
    [layer addAnimation:animation forKey:@"strokeEnd"];
    [self.layer addSublayer:layer];
}

#pragma mark 计算圆圈上点在IOS系统中的坐标
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center angle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x2 = radius * cosf(angle * M_PI / 180);
    CGFloat y2 = radius * sinf(angle * M_PI / 180);
    return CGPointMake(center.x + x2, center.y - y2);
}

@end
