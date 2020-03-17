//
//  LTTimer.m
//  LTDemo
//
//  Created by 刘涛 on 2019/6/12.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTProxy.h"

@interface LTProxy ()

@property (nonatomic, weak) id target;

@end

@implementation LTProxy

- (instancetype)initWIthTarget:(id)target{
    _target = target;
    return self;
}

//- (id)forwardingTargetForSelector:(SEL)selector {
//    if (!_target) {
//
//    }
//    return _target;
//}
//
//- (void)dealloc{
//    NSLog(@"proxy销毁了");
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation{
//    if ([self.target respondsToSelector:invocation.selector]) {
//        [invocation invokeWithTarget:self.target];
//    }
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    if (!self.target) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    if ([self.target respondsToSelector:sel]) {
        return [self.target methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:sel];
}

-  (void)forwardInvocation:(NSInvocation *)invocation{
    if (self.target) {
        invocation.target = self.target;
        [invocation invoke];
    }
}

@end
