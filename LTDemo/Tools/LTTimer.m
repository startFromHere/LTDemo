//
//  LTTimer.m
//  LTDemo
//
//  Created by 刘涛 on 2019/8/27.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTTimer.h"

@interface LTTimer()

@property (nonatomic, strong) NSTimer *internalTimer;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL bindedSelector;

@end


@implementation LTTimer

+ (instancetype)timerWithTarget:(id)target task:(SEL)selector repeats:(BOOL)repeat{
    LTTimer *instance = [[LTTimer alloc] init];
    instance.bindedSelector = selector;
    instance.target = target;
    instance.internalTimer = [NSTimer timerWithTimeInterval:1 target:instance selector:selector userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:instance.internalTimer forMode:NSRunLoopCommonModes];
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == self.bindedSelector) {
        if (!self.target) {
            return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        }
        return [self.target methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if (anInvocation.selector == self.bindedSelector) {
        if (self.target) {
            anInvocation.target = self.target;
            [anInvocation invoke];
        }
        return;
    }
    [super forwardInvocation:anInvocation];
}


@end
