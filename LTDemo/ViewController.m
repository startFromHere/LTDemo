//
//  ViewController.m
//  LTDemo
//
//  Created by 刘涛 on 3/25/19.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)injected{
    //...
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"点击进入测试页面";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

#pragma mark - 进入测试页面
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self enterInViewControllerByName:@"LTRunloopTestVC"];
}

- (void)enterInViewControllerByName:(NSString *)name{
    UIViewController *vc = (UIViewController *)[NSClassFromString(name) new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

