//
//  QAnimationBallClipRotate.m
//  ActivityIndicatorAnimation
//
//  Created by 009 on 2017/8/8.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "QAnimationBallClipRotate.h"

@implementation QAnimationBallClipRotate

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CFTimeInterval duration = 0.75;

        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.keyTimes = @[@0, @0.5, @1];
        scaleAnimation.values = @[@1, @0.6, @1];

        CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.keyTimes = scaleAnimation.keyTimes;
        rotateAnimation.values = @[@0, @M_PI, @(2*M_PI)];

        CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
        animation.animations = @[rotateAnimation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = duration;
        animation.repeatCount = HUGE;
        [animation setRemovedOnCompletion:NO];

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 - 8 startAngle:-M_PI/4 endAngle:M_PI/4 clockwise:NO];

        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.backgroundColor = nil;
        layer.fillColor = nil;
        layer.path = path.CGPath;
        layer.lineWidth = 2;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [layer addAnimation:animation forKey:@"animation"];
        [self.layer addSublayer:layer];
    }
    return self;
}

@end
