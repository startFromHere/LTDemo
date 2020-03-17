//
//  LTMethodSwizzSubOBJ1+add.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/16.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTMethodSwizzSubOBJ1+add.h"

@implementation LTMethodSwizzSubOBJ1 (add)

+ (void)load{
    Method originMethod = class_getInstanceMethod(self, @selector(testMethod));
    Method swizzMethod = class_getInstanceMethod(self, @selector(lt_testMethod));
    
    //（warn:如果仅仅是这样交换方法, 如果原方法是一个子类未实现的方法（未重写父类方法），此时如果调用该方法，runtime会从父类找对应实现，如果父类的分类恰好重写了该方法，所以最终会进入改分类的实现，而在分类的实现中又调用了 self xxx, 而在消息发送阶段该self 是子类的类对象，所以又相当于又要重新调用子类的方法，这样就进入死循环）
//    method_exchangeImplementations(originMethod, swizzMethod);
    
    {//代码段1
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
    
//    {//代码段2
//    BOOL success = class_addMethod([self class],
//                    @selector(testMethod),
//                    method_getImplementation(originMethod),
//                    method_getTypeEncoding(originMethod));
//    method_exchangeImplementations(originMethod, swizzMethod);
//    }
    
    //代码段1 和 代码段2 效果是否相同
}

- (void)lt_testMethod{
    NSLog(@"%@ 调用了子类的分类的hook的方法",NSStringFromClass(self.class));
    [self lt_testMethod];
}

@end
