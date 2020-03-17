//
//  LTMethodSwizzBaseOBJ.h
//  LTDemo
//
//  Created by 刘涛 on 2019/7/16.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTMethodSwizzBaseOBJ : NSObject

- (void)testMethod;

//父类未实现的方法
- (void)testMethod2;

@end

NS_ASSUME_NONNULL_END
