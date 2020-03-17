//
//  LTRuntimeTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/8/5.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTRuntimeTestVC.h"
#import <objc/runtime.h>
#import "LTMethodSwizzBaseOBJ+add.h"
#import "LTMethodSwizzSubOBJ1+add.h"


@interface NSObject(Sark)

+ (void)foo;

@end

@implementation NSObject(Sark)

- (void)foo{
    NSLog(@"IMP: -[NSObject(Sark) foo]");
}

@end


@interface LTRuntimeTestVC ()

@end

@implementation LTRuntimeTestVC

- (void)injected{
//    [self isaTest];
    [self circleReferenceTest];
}

- (void)circleReferenceTest{
//    dog.owner = nil;
}

- (void)isaTest{
//    BOOL b1 = [[NSObject class] isKindOfClass:[NSObject class]];
//    BOOL b2 = [[NSObject class] isMemberOfClass:[NSObject class]];
//    BOOL b3 = [[Student class] isKindOfClass:[Student class]];
//    BOOL b4 = [[Student class] isMemberOfClass:[Student class]];
//    Class cls = objc_getClass(class_getName([Student class]));
//    Class cls2 = [Student class];
//    Class metaCls = objc_getMetaClass(class_getName([Student class]));
//    BOOL b5 = [[Student class] isMemberOfClass:cls];
    
    [NSObject foo];
    [[NSObject new] foo];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test2];
}

#pragma mark -属性、成员变量拷贝


#pragma mark -方法交换
- (void)test2{
    LTMethodSwizzSubOBJ1 *obj1 = [[LTMethodSwizzSubOBJ1 alloc] init];
    [obj1 testMethod];
}

#pragma mark -getimplementation


@end
