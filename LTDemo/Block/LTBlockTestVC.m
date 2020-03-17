//
//  LTBlockTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/7.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTBlockTestVC.h"
#import "LTPerson.h"
#import "Manager.h"

struct MYStruct{
    int value;
    char *name;
};

static struct MYStruct *myP;

@interface LTBlockTestVC ()

@property (nonatomic, strong) Manager *strongManager;

@end

@implementation LTBlockTestVC

- (void)injected
{
//    [self ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self crashTest];
}

#pragma mark - 测试crash问题 https://suhou.github.io/2019/05/21/%E4%BB%8E%E4%B8%80%E4%B8%AAcrash%E4%BD%93%E9%AA%8Cstrong%E7%9A%84%E5%BB%B6%E8%BF%9F%E9%87%8A%E6%94%BE/
- (void)crashTest{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // 模拟网络请求
    self.strongManager = [Manager new];
    __weak typeof(self) weakSelf = self;
    self.strongManager.endBlock = ^{
        weakSelf.strongManager = nil;
    };
    
//    self.strongOperation = [Operation new];
//    [self.strongOperation setTarget:self.strongManager selector:@selector(testMethod)];
    
}

- (void)btnAction:(id)sender{
    /*
     1.第一种方式，invocation 调用方法，target可能在使用过程中释放
     2.第二种方式，直接通过属性getter获取对象时，会调用_objc_retainAutoreleaseReturnValue，保证对象在使用过程中不被销毁
     */
    #pragma mark -方式1
//    NSMethodSignature *signature = [self.strongManager methodSignatureForSelector:@selector(excuteBlock)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    [invocation setTarget:self.strongManager];
//    [invocation setSelector:@selector(excuteBlock)];
//    [invocation invoke];
    
    #pragma mark -方式2
//    [_strongManager excuteBlock];//该方式仍然可能导致对象在使用过程中销毁
    [self.strongManager excuteBlock];
}

- (void)staticDataLifeTimeTest{
    static int a = 0;
    if (a == 0) {
        a = 1;
        struct MYStruct s = {
            29,
            "hallen"
        };

        myP =&s;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self staticDataLifeTimeTest];
    printf("域外myP->value:%d   myP->name:%s",myP->value,myP->name);
}

@end
