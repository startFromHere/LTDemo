//
//  Manager.m
//  LTDemo
//
//  Created by 刘涛 on 2020/3/10.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "Manager.h"

@implementation Manager
#pragma mark - 方式一
- (void)excuteBlock{
    if (self.endBlock) {
        self.endBlock();
    }
    NSLog(@"%@", self);
}

- (void)dealloc{
    NSLog(@"dealloc");
}
@end
