//
//  NSObject+LTModel.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/6.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "NSObject+LTModel.h"
#import <objc/runtime.h>

@implementation NSObject (LTModel)

+ (instancetype)ltModelWithDictionary:(NSDictionary *)dic{
    NSMutableArray *ivars = [NSMutableArray array];
    NSMutableArray *properties = [NSMutableArray array];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        [ivars addObject:ivarName];
    }
    
    objc_property_t *propertyT = class_copyPropertyList(self, &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = propertyT[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [properties addObject:propertyName];
    }
    
    return nil;
}

@end
