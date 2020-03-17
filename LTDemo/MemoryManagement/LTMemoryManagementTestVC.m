//
//  LTMemoryManagementTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/16.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTMemoryManagementTestVC.h"

@interface LTMemoryManagementTestVC ()

@property (nonatomic, strong) UIView *animateView;

@end

@implementation LTMemoryManagementTestVC

__weak NSString *weakStr_ = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 80)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [view addGestureRecognizer:tap];
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 80, 40)];
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self test];
//    [[Person alloc] init];
//
//    __weak Person *p = [[Person alloc] init];
//    p.name = @"李四";
//
//    NSLog(@"2333333");
    
//    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//
//    }];
    
//    [self personReleaseTest];
}

- (void)rotate:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    CGAffineTransform transform;
    if (CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
        transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        transform = CGAffineTransformIdentity;
    }
    view.transform = transform;
    if (@available(iOS 13.0, *)) {
        view.transform = transform;
    }
    // 开始旋转
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    printf(__PRETTY_FUNCTION__);
}

- (void)test2{
    for (int i=0; i<300000; i++) {
//        @autoreleasepool {
        
        //autorelease
//            NSString *string = [NSString stringWithFormat:@"%d%d%d%d%d%d%d%d%d%d",arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random()];
        
        NSString *string = [NSString stringWithFormat:@"890839103890890dios"];
        
        //autorelease
//            NSString *str = [[NSString alloc] initWithFormat:@"%d%d%d%d%d%d%d%d%d%d",arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random(),arc4random()];
//        }
    }
}

- (void)mrcTest{
    //设置编译参数
}

- (void)test{
    //场景1
    NSString *string = [NSString stringWithFormat:@"liutao"];
    weakStr_ = string;
    
    //场景2
    //    @autoreleasepool {
    //        NSString *string = [NSString stringWithFormat:@"liutao"];
    //        weakStr_ = string;
    //    }
    
    //场景3
    //    NSString *string = nil;
    //    @autoreleasepool {
    //        string = [NSString stringWithFormat:@"liutao"];
    //        weakStr_ = string;
    //    }
    
    NSLog(@"string: %@", weakStr_);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"string: %@", weakStr_);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"string: %@", weakStr_);
}

@end
