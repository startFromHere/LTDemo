//
//  NSObject+LTModel.h
//  LTDemo
//
//  Created by 刘涛 on 2020/1/6.
//  Copyright © 2020 刘涛. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LTModel)

+ (instancetype)ltModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
