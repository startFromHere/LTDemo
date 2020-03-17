//
//  LTModel.h
//  LTDemo
//
//  Created by 刘涛 on 2020/1/6.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTPerson : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *age;

+ (instancetype)perseon;

@end

NS_ASSUME_NONNULL_END
