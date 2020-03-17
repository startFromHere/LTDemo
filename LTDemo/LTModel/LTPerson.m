//
//  LTModel.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/6.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTPerson.h"

@implementation LTPerson

+ (instancetype)perseon{
    return [[self alloc] init];
}

- (void)dealloc{
    NSLog(@"person销毁了...");
}


@end
