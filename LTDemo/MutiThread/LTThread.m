//
//  LTThread.m
//  LTDemo
//
//  Created by 刘涛 on 2019/6/18.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTThread.h"

@implementation LTThread

+ (instancetype)longliveThread{
    LTThread *thread = [[LTThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSRunLoopCommonModes];
        while (self) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    [thread start];
    return thread;
}

- (void)dealloc{
    NSLog(@"线程销毁了");
}

@end
