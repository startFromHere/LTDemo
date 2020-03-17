//
//  LTLifeCircleTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/3/10.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTLifeCircleTestVC.h"

@interface LTLifeCircleTestVC ()

@end

@implementation LTLifeCircleTestVC

+ (void)load{
    //load
}

+ (void)initialize{
    [super initialize];
}

- (void)loadView{
    [super loadView];
//    self.view = [[LTView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
