//
//  main.m
//  LTDemo
//
//  Created by 刘涛 on 3/25/19.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LTPerson.h"


int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
////    __weak NSString *weakP;//为什么加上这行 下面的LTPerson对象会延迟释放，而不加这行，下面的person会在其作用域结束时释放？
//    {
//        LTPerson *p = [LTPerson perseon];
////        LTPerson *p1 = [LTPerson new];
//    };
//    return 0;
}
