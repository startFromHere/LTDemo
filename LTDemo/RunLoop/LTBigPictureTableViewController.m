//
//  LTBigPictureTableViewController.m
//  LTDemo
//
//  Created by 刘涛 on 2019/12/31.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTBigPictureTableViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface LTBigPictureTableViewController ()

@property (nonatomic, strong) NSMutableArray *tasks;

@end

const NSUInteger MaxTaskCount = 18;

@implementation LTBigPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks = [NSMutableArray array];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //创建一个runloop的观察者,监听到进入waiting状态时的回调函数
    __weak typeof(self) weakSekf = self;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                                       kCFRunLoopBeforeWaiting,
                                                                       YES,
                                                                       0,
                                                                       ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        //取出一个任务队列中的任务并执行
        [weakSekf executeTask];
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 repeats:YES block:^(NSTimer * _Nonnull timer) {

    }];
}

#pragma mark -执行任务
- (void)executeTask{
    if (self.tasks.count > 0) {
        void(^task)(void) = self.tasks[0];
        task();
        [self.tasks removeObjectAtIndex:0];
    } else {
//        NSLog(@"没有任务了");
    }
}

#pragma mark -添加任务
- (void)addTask:(void(^)(void))task{
    [self.tasks addObject:task];
    if (_tasks.count > MaxTaskCount) {
        [_tasks removeObjectAtIndex:0];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = nil;
    
    [self addTask:^{
        NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"bigPic" withExtension:@"png"]];
        UIImage *img = [UIImage imageWithData:data];
        cell.imageView.image = img;
    //由于该block需要延后执行，而在执行block前，cell可能已经调用了layoutSubviews方法，那时候它发现没有image，于是imageview的frame为空，因此这里需要主动调用 setNeedsLayout 方法
        [cell setNeedsLayout];
    }];
    static int count = 0;
    
    NSLog(@"count:%d",count++);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    static int a = 0;
    if (a == 0) {
        a = 1;
        
    }
}

- (void)dealloc{
    NSLog(@"VC 销毁了");
}

@end
