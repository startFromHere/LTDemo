//
//  Manager.h
//  LTDemo
//
//  Created by 刘涛 on 2020/3/10.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

@property (nonatomic, copy) void(^endBlock)(void);

- (void)excuteBlock;

@end

NS_ASSUME_NONNULL_END
