//
//  LTAutoreleasepoolTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/29.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTAutoreleasepoolTestVC.h"

@interface LTAutoreleasepoolTestVC (){
    __weak NSString *myStr1;
    __weak NSString *myStr2;
    __weak NSString *myStr3;
}

@end



@implementation LTAutoreleasepoolTestVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"autoreleasepool test";
    
    NSString *str1 = @"111";
    myStr1 = str1;
    
    NSString *str2;
    {
        str2 = [NSString stringWithFormat:@"222"];
    }
    myStr2 = str2;
    
    NSString *str3 = [NSString stringWithFormat:@"333"];
    myStr3 = str3;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self log];
}
    
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self log];
}
    
- (void)log{
    NSLog(@"str1:%@  str2:%@  str3:%@",myStr1, myStr2, myStr3);
}

@end
