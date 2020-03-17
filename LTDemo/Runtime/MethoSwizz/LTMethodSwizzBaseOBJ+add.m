//
//  LTMethodSwizzBaseOBJ+add.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/16.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTMethodSwizzBaseOBJ+add.h"
#import <objc/runtime.h>

@implementation LTMethodSwizzBaseOBJ (add)

+ (void)load{
    
    Method originMethod = class_getInstanceMethod(self, @selector(testMethod));
    Method swizzMethod = class_getInstanceMethod(self, @selector(lt_testMethod));

    //只是方法交换
//    method_exchangeImplementations(originMethod, swizzMethod);
    
    
    //需要考虑原方法是否实现
    BOOL success = class_addMethod([self class],
                                   @selector(testMethod),
                                   method_getImplementation(swizzMethod),
                                   method_getTypeEncoding(swizzMethod));
    if (success) {
        class_replaceMethod([self class],
                            @selector(lt_testMethod),
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzMethod);
    }
}

- (void)lt_testMethod{
    NSLog(@"%@ 调用了基类的分类的hook的方法",NSStringFromClass(self.class));
    [self lt_testMethod];
}

- (void)testMethod_extension{
    NSLog(@"this is a category method");
}

@end
