//
//  LTThreadSyncTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2020/1/15.
//  Copyright © 2020 刘涛. All rights reserved.
//

#import "LTThreadSyncTestVC.h"
#import <libkern/OsAtomic.h>

@interface LTThreadSyncTestVC ()

@property (nonatomic, assign) int remainedTickets;

@property (nonatomic, assign) float balance;

@property (nonatomic, assign) OSSpinLock lock;

@end

@implementation LTThreadSyncTestVC

- (void)injected{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _balance = 1000;
    _remainedTickets = 1210;
    _lock = OS_SPINLOCK_INIT;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //
    [self saveMoneyTest];
}

#pragma mark -卖票
- (void)soldTicketTest{
    dispatch_queue_t queue = dispatch_queue_create("queue_soldTickets", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self soldTicket:1];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self soldTicket:2];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self soldTicket:1];
        }
    });
}

- (void)soldTicket:(int)num{
    OSSpinLockLock(&_lock);
    NSLog(@"当前剩余票数：%d",_remainedTickets);
    int a = _remainedTickets;
    sleep(.1);
    a -= num;
    _remainedTickets = a;
    NSLog(@"卖完%d张票，剩余票数：%d", num,_remainedTickets);
    OSSpinLockUnlock(&_lock);
}

#pragma mark -存钱
- (void)saveMoneyTest{
    dispatch_queue_t queue = dispatch_queue_create("queue_soldTickets", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self saveMoney:10.0];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self drawMoney:8.0];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i<100; i++) {
            [self drawMoney:2.0];
        }
    });
}

- (void)saveMoney:(float)amount{
    OSSpinLockLock(&_lock);
    NSLog(@"存钱前，余额：%.2f",_balance);
    int a = _balance;
    a += amount;
    _balance = a;
    NSLog(@"存钱后，余额：%.2f", _balance);
    OSSpinLockUnlock(&_lock);
}

- (void)drawMoney:(float)amount{
    OSSpinLockLock(&_lock);
    NSLog(@"取钱前，余额：%.2f",_balance);
    int a = _balance;
    a -= amount;
    _balance = a;
    NSLog(@"取钱后，余额：%.2f", _balance);
    OSSpinLockUnlock(&_lock);
}

@end
