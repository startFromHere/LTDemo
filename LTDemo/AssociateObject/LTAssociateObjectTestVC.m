//
//  LTAssociateObjectTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/8.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTAssociateObjectTestVC.h"

///
@interface LTWeakAssociatedObjectWrapper : NSObject

@property (nonatomic, weak) id object;

@property (nonatomic, weak) id delegate;

@end

@implementation LTWeakAssociatedObjectWrapper

-(void)dealloc{
    printf(__PRETTY_FUNCTION__);
}

@end

///
@interface LTDeallocHandleObj : NSObject

@property (nonatomic, copy) void(^deallocBlock)(void);

@end

@implementation LTDeallocHandleObj

- (void)dealloc{
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}

@end


///
@interface UIView(LTAdd)

@property UIViewController *vc;

@end

@implementation UIView(LTAdd)

- (void)setVc:(UIViewController *)vc{
    [self willChangeValueForKey:@"vc"];
    LTWeakAssociatedObjectWrapper *wrapper = [LTWeakAssociatedObjectWrapper new];
    wrapper.object = vc;
    LTDeallocHandleObj *obj = [LTDeallocHandleObj new];
    __weak typeof(self) weakSelf = self;
    __weak typeof(vc) weakVC = vc;
    obj.deallocBlock = ^{
        if (weakVC) {
            weakSelf.vc = nil;
        }
    };
    objc_setAssociatedObject(vc, (__bridge const void *)obj, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, @selector(vc), wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"vc"];
    
    
    //这种方式不持有vc
//    vc = [LTAssociateObjectTestVC new];
//    objc_setAssociatedObject(self, @selector(vc), vc, OBJC_ASSOCIATION_ASSIGN);
    //这种方式强持有vc 可能造成循环引用问题
//    objc_setAssociatedObject(self, @selector(vc), vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)vc{
    LTWeakAssociatedObjectWrapper *wrapper = objc_getAssociatedObject(self, _cmd);
    return wrapper.object;
    
//    return objc_getAssociatedObject(self, _cmd);
}

@end



@interface LTAssociateObjectTestVC ()

@end

@implementation LTAssociateObjectTestVC

- (void)injected{
    
    id vc = self.view.vc;
    
    self.view.vc = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)dealloc{
    NSLog(@"dddd");
}

@end
