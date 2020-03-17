//
//  LTRunloopTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/6/18.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTRunloopTestVC.h"
#import "LTThread.h"

@interface LTRunloopTestVC ()

@property (nonatomic, strong) NSPort *port;

@property (nonatomic, strong) NSTimer *mainThreadTimer;

@property (nonatomic, strong) NSTimer *globalThreadTimer;

@property (nonatomic, assign) int number;

@end

@implementation LTRunloopTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self addTimerInMainThread];
    
    [self addTimerInGlobalThread];
}

- (void)runloopObserver{
    //创建一个runloop的观察者,监听到进入waiting状态时的回调函数
    __weak typeof(self) weakSekf = self;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                                       kCFRunLoopBeforeSources,
                                                                       YES,
                                                                       0,
                                                                       ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"进入了runloop");
       
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    
}

#pragma mark -主线程 timer
- (void)addTimerInMainThread{
    __weak typeof(self) weakSelf = self;
    self.mainThreadTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf threadTest];
    }];
}

#pragma mark -全局线程 timer
- (void)addTimerInGlobalThread{
    __weak typeof(self) weakSelf = self;
    
    //一、下面的方式没有持有timer，不能在合适的时机执行 invalidated，退出页面后，timer回调时间仍然继续执行
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"number:%d",weakSelf.number++);
//        }];
//
//        [[NSRunLoop currentRunLoop] run];
//        NSLog(@"是否执行了？这句话没有执行，所以dispatch_async这层的 block 不能执行完，也就不能销毁");
//        //block 对内部使用的对象会产生强引用，但是苹果会在cgd 的block 执行结束后，自动断掉引用，所以不存在循环引用的问题，但在这里，由于手动执行了[runloop run],代码会一直在其内部循环，也就不能结束 block，所以导致 self 无法释放
//    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        weakSelf.globalThreadTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            //这里使用strongSelf，是为了保证在该block执行过程中，
            __strong typeof(weakSelf) stronSelf = weakSelf;
            sleep(4);
//            在block执行后4s内，退出当前页面，由于block强持有一个局部变量strongSelf，所以在block执行期间，strongSelf（weakSelf）对象一直存在，如果这里没有标记一个__strong 变量指向self，那么self会直接释放，下面方法不会执行（向nil发送消息）
            [weakSelf threadTest];
        }];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)threadTest{
    NSLog(@"11111");
}

- (void)openCountdown:(id)sender {
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer,DISPATCH_TIME_NOW,1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            
            NSLog(@"结束!");
            
        }else{
            
            int seconds = time % 60;
            NSLog(@"%@",[NSString stringWithFormat:@"重新发送(%.2d)",seconds]);
            
            time--;
        }
    });
    
    dispatch_resume(timer);
}

- (void)execute:(id)task{
    
}


- (void)dealloc{
    NSLog(@"销毁了");
    [self.globalThreadTimer invalidate];
}

@end
