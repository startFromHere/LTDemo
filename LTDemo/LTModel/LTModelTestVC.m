//
//  LTModelTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/6.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTModelTestVC.h"
//#import "NSObject+LTModel.h"
#import "MJExtension.h"
#import "LTStudent.h"

@interface LTModelTestVC ()

@property(nonatomic, weak) void(^block)();

@end

@implementation LTModelTestVC

int constA = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic = @{
        @"name" : @"tom",
        @"age" : @20,
        @"major" : @"Math"
    };
    
    LTStudent *s = (LTStudent *)[LTStudent mj_objectWithKeyValues:dic];
    int val = 10;
    
    static int sA = 1;
    void(^blockA)() = ^{
//        NSLog(@"eer");
        NSLog(@"val:%d, %@", val,self);
        constA = 100;
        sA = 2;
//        val = 3;
    };
    NSLog(@"%@", blockA);
    _block = blockA;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", _block);
}

- (void)dealloc{
    NSLog(@"dd");
}


@end
