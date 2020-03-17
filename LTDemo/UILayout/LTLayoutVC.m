//
//  LTLayoutVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/12/4.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTLayoutVC.h"

@interface LTLayoutVC ()

@end

@implementation LTLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.barTintColor = UIColor.redColor;
    
    [self setup];
    
}

- (void)setup{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 100)];
    [self.view addSubview:scroll];
    scroll.backgroundColor = UIColor.grayColor;
    scroll.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
    scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = UIColor.orangeColor;
    [scroll addSubview:v];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
