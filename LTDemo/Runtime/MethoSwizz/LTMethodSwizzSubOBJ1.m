//
//  LTMethodSwizzSubObj1.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/16.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTMethodSwizzSubOBJ1.h"

@implementation LTMethodSwizzSubOBJ1


//- (void)testMethod{
//    NSLog(@"LTMethodSwizzSubObj1 调用了 testMehtod 没有调用super的方法");
//}

//#pragma mark -子类重写并调用了super的同名方法，如果父类的分类进行了方法交换，且在交换的方法中调用了原方法，会造成死循环
//- (void)testMethod{
//    [super testMethod];
//    NSLog(@"LTMethodSwizzSubObj1 调用了 testMehtod 且调用了super的方法");
//}

- (void)testMethod2{
    [super testMethod2];
    NSLog(@"LTMethodSwizzSubObj1 调用了super 未实现的方法");
}

@end
