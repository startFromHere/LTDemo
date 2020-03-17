//
//  LTAnimationTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/8/15.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTAnimationTestVC.h"

@interface LTAnimationTestVC ()

@property (nonatomic, strong) UIView *animateView;

@end

@implementation LTAnimationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    self.animateView.backgroundColor = UIColor.grayColor;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = UIColor.orangeColor.CGColor;
    layer.frame = self.animateView.bounds;
    [self.animateView.layer addSublayer:layer];
    [self.view addSubview:self.animateView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self group_animation_test];
}

- (void)basic_animation_test{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @125;
    animation.toValue = @455;
    animation.duration = 2;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.5 :0 :.9 :.7];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.animateView.layer addAnimation:animation forKey:@"drop"];
}

- (void)keyframe_animation_test{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.y";
    animation.values = @[@200, @300, @310, @380, @450];
    animation.keyTimes = @[@0, @(1.0/4), @(2.0/4), @(3.0/4), @1];
    animation.duration = 2;
    
    
    animation.additive = YES;
    [self.animateView.layer addAnimation:animation forKey:@"drop"];
}

- (void)orbit_animation_test{
    
    CGPathRef path = CGPathCreateWithRect(CGRectMake(50, 100, 300, 500), NULL);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = path;
    CFRelease(path);
    
    orbit.duration = 5;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.animateView.layer addAnimation:orbit forKey:@"rectcircle"];
}

- (void)group_animation_test{
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.5, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, 500)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
//    [self.animateView.layer addAnimation:position forKey:@"12"];
//    return;

    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ rotation ];
    group.duration = 1.2;
//    group.beginTime = 0.1;
    
    [self.animateView.layer addAnimation:group forKey:@"shuffle"];
    
//    self.animateView.layer.zPosition = 1;
}

@end
