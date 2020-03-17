//
//  LTNetworkViewController.m
//  LTDemo
//
//  Created by 刘涛 on 2019/8/12.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTNetworkViewController.h"

@interface LTNetworkViewController ()

@end

@implementation LTNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSURLSession *session = [[NSURLSession alloc] init];
    [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    [task resume];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"www.baidu.com"]];

}

@end
