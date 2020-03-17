//
//  LTTimer.h
//  LTDemo
//
//  Created by 刘涛 on 2019/8/27.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTTimer : NSObject

+ (instancetype)timerWithTarget:(id)target task:(SEL)selector repeats:(BOOL)repeat;

- (void)stop;

- (void)reStart;

@end

NS_ASSUME_NONNULL_END
