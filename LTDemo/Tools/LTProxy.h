//
//  LTTimer.h
//  LTDemo
//
//  Created by 刘涛 on 2019/6/12.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTProxy : NSProxy

- (instancetype)initWIthTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
