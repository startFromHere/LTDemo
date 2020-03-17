//
//  LTMutiThreadTestVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/6/10.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTMutiThreadTestVC.h"
#import "LTThread.h"
#import "LTOperationQueue.h"

@interface LTMutiThreadTestVC (){
    dispatch_semaphore_t semaphore;
}

@property (nonatomic, strong) dispatch_queue_t taskQueue;

@property (nonatomic, strong) NSOperation *op;

@property (nonatomic, strong) LTThread *myThread;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, weak) NSOperationQueue *queue;

@end

@implementation LTMutiThreadTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
   
    
//    [self runloopTest];
//    [self gcdTest];
//    [self queueTest];
    
//    id lastVC = self.navigationController.viewControllers.lastObject;
}

- (void)test1{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"task1");
        [self performSelector:@selector(logTask2) withObject:nil afterDelay:.0];
        [self performSelector:@selector(logTask4) withObject:nil afterDelay:3];
        NSLog(@"task3");
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:2];
        [[NSRunLoop currentRunLoop] runUntilDate:date];
    });
}

- (void)test2{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(mainQ, ^{
        NSLog(@"task1");
        
    });
    
    NSLog(@"task2");
}

- (void)test3{
    dispatch_queue_t queue = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_queue_create("queue3", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"task1");
        dispatch_sync(queue, ^{
            NSLog(@"task2");
        });
        NSLog(@"task3");
    });
    
    NSLog(@"task4");
}
- (void)logTask2{
    NSLog(@"task2");
}
- (void)logTask4{
    NSLog(@"task4");
}

- (void)test4{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务1");
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务2");
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务3");
    });
    
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        sleep(1+arc4random()%5);
        NSLog(@"任务5");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        sleep(1+arc4random()%5);
        NSLog(@"任务6");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务7");
    });
    
    
    
    NSLog(@"任务4");
}

- (void)runloopTest{
    __weak typeof(self) weakSelf = self;
    self.myThread = [[LTThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf timerAction];
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
//    [_myThread start];
    
    UIImageView *v = [UIImageView new];
    v.frame = self.view.bounds;
    v.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:v];
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = self.view.bounds;
    layer.contents = (id)[UIImage imageNamed:@"ad1"].CGImage;
    [v.layer addSublayer:layer];
//    layer.contentsRect = CGRectMake(0.25, 0.25, 1.5, 1.5);
}

- (void)timerAction{
    NSLog(@"timer 事件。。。");
}



- (void)gcdTest{
    NSLog(@"主线程1");
    
    dispatch_queue_t queue = dispatch_queue_create("ddd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"主线程兵法队列队列任务");
    });
    
    for (int i=0; i<10; i++) {
        NSLog(@"主线程2");
    }
}

- (void)queueTest{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    
    for (int i=0; i<10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"dddd%d",i+1);
        });
    }
    
    
    for (int i=0; i<10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"mmmm%d",i+1);
        });
    }
    
    self.taskQueue = dispatch_queue_create("taskQueue", DISPATCH_QUEUE_CONCURRENT);
    semaphore = dispatch_semaphore_create(6);
    
    [self addTestButton];
    [self creatNumLables];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.dic[@"arr"] removeLastObject];
}

- (void)addTestButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, (ScreenWidth-60)/2, 40);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake((ScreenWidth-60)/2 + 30, 100, (ScreenWidth-60)/2, 40);
    [button2 setTitle:@"清空" forState:UIControlStateNormal];
    [button2 setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)creatNumLables{
    CGFloat labelWidth = ScreenWidth/15;
    CGFloat labelHeight = 20;
    for (int i=0; i<200; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i%15)*labelWidth, ScreenHeight - 380 + i/15 * labelHeight, labelWidth, labelHeight)];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.borderColor = UIColor.lightGrayColor.CGColor;
        label.layer.borderWidth = .5;
        label.tag = i+100;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:label];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test4];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = UIColor.orangeColor;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    Student *s = [Student new];
//    [s performSelector:@selector(read) withObject:nil afterDelay:2];
//    [s performSelector:@selector(read) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    
//    [s performSelector:@selector(read) onThread:[LTThread new] withObject:nil waitUntilDone:YES];
    
//    self.myThread = [LTThread longliveThread];
//    [s performSelector:@selector(read) onThread:_myThread withObject:nil waitUntilDone:NO];
//
//    for (int i=0; i<100; i++) {
//        NSLog(@"12121212");
//    }
//    [self dispatchBarrierTest];
//    [self dispatchGroupTest];
    

//    描述：根据是否需要获取用户信息，作出后续操作，如果需要获取信息，先异步获取用户信息，获取成功后，打印信息；如果不需要用户信息，直接打印“不需要用户信息
    [self testWithOperation];
    
}

- (void)dispatchGroupTest{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.lt.dispatch_group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_enter(group);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务一");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务二");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务三");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务四");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"插入的新任务");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务五");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务六");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务七");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务八");
    });
    
}


- (void)dispatchBarrierTest{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务1");
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务2");
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务3");
//    });
    
//    dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"barrier执行了");
//    });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务4");
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务5");
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"任务6");
//    });
    
    dispatch_queue_t barrierQueue = dispatch_queue_create("com.lt.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务1");
    });
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务2");
    });
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务3");
    });
    
    dispatch_barrier_async(barrierQueue, ^{
        NSLog(@"barrier执行了");
    });
    
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务4");
    });
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务5");
    });
    dispatch_async(barrierQueue, ^{
        NSLog(@"任务6");
    });
}


- (void)test{
//    [self createNumsDirectlyByMutiThread];
    //这种方式可以
//    [self createNumesBySemaphore2];
    
    //这种方式有问题
    [self createNumesBySemaphore3];

    
//    [self createNumsByNSBlockOperation];
    
//    [NSThread detachNewThreadSelector:@selector(createNumsByNSBlockOperation) toTarget:self withObject:nil];
    
//    [self createNumsByOpetationQueue];
}

//在并发队列中sleep
- (void)createNumesBySemaphore1{
    for (int i=0; i<20; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
                dispatch_semaphore_signal(semaphore);
            });
        });
    }
}


//在并发队列中循环
- (void)createNumesBySemaphore2{
    dispatch_async(self.taskQueue, ^{
        for (int i=0; i<100; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UILabel *label = [self.view viewWithTag:i+100];
                    label.text = [NSString stringWithFormat:@"%d",i];
                    dispatch_semaphore_signal(semaphore);
                });
            });
        }
    });
}

//先循环，在循环体中创建并发队列（会有死锁）
- (void)createNumesBySemaphore3{
    for (int i=0; i<760; i++) {
        dispatch_async(self.taskQueue, ^{
            //为什么在这里 wait 会有死锁？？
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //为什么在这里 wait 没问题？？
//                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UILabel *label = [self.view viewWithTag:i+100];
                    label.text = [NSString stringWithFormat:@"%d",i];
                    dispatch_semaphore_signal(semaphore);
                });
            });
        });
    }
}



- (void)clear{
    [self.op cancel];
    
    for (int i=0; i<200; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i+100];
        label.text = nil;
    }
}

//1.直接通过子线程创建多条数据并显示
- (void)createNumsDirectlyByMutiThread{
    for (int i=0; i<200; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            CGFloat duration = arc4random()%100 * 0.01 + 0.3;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        });
    }
}

//2.通过信号量机制每次创建10个数字并显示
- (void)createNumesBySemaphore{
    for (int i=0; i<200; i++) {
        dispatch_async(self.taskQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            sleep(1.2);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
            
            dispatch_semaphore_signal(semaphore);
            
        });
    }
}



//3.通过 operationqueue 创建数字
- (void)createNumsByNSBlockOperation{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<200; i++) {
            CGFloat duration = arc4random()%100 * 0.01 + 0.04;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    }];
    
    NSBlockOperation *finishOp = [NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"执行完毕！");
    }];
    self.op = finishOp;
    
    [finishOp addDependency:operation];
    
    [operation start];
    [finishOp start];
}

- (void)createNumsByOpetationQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 13;
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<50; i++) {
            CGFloat duration = arc4random()%100 * 0.01 + 0.04;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=50; i<100; i++) {
            CGFloat duration = arc4random()%100 * 0.01 + 0.04;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=100; i<150; i++) {
            CGFloat duration = arc4random()%100 * 0.01 + 0.04;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=150; i<200; i++) {
            CGFloat duration = arc4random()%100 * 0.01 + 0.04;
            sleep(duration);
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [self.view viewWithTag:i+100];
                label.text = [NSString stringWithFormat:@"%d",i];
            });
        }
    }];
    
    NSBlockOperation *finishOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行完毕！");
    }];
    self.op = finishOp;
    
//    [operation start];
//    [operation2 start];
//    [operation3 start];
//    [operation start];
    
    [queue addOperation:operation];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    
    
    [finishOp addDependency:operation];
    [finishOp addDependency:operation2];
    [finishOp addDependency:operation3];
    [finishOp addDependency:operation4];
    
    [queue addOperation:finishOp];
    
}

#pragma mark -执行某些任务后，再执行其他任务
- (void)test_excuteSomeTaskAfterOtherTasksFinished{
//    [self testWithDispatchgroup];
//    [self testWithSemaphore];
    [self testWithOperation];
}

    
- (void)testWithSemaphore{
    BOOL needUserinfo = arc4random()%2;
    
    __block NSString *userinfo;
    if (needUserinfo) {
        semaphore = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            userinfo = @"模拟异步获取到的用户信息";
            dispatch_semaphore_signal(semaphore);
            //注意1.这里 dispatch_semaphore_signal 不能在主线程调用，因为方法只是到这里的时候，主线程已经处于等待信号释放的状态了（标记1），这里释放信号会造成死锁
            //注意2：Calls to dispatch_semaphore_signal must be balanced with calls to wait(). Attempting to dispose of a semaphore with a count lower than value causes an EXC_BAD_INSTRUCTION exception.
        });
    } else {
        userinfo = @"不需要用户信息";
    }
    
    if (semaphore) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//标记1
    }
    NSLog(@"用户信息：%@",userinfo);
}

#pragma mark -用 dispatchgroup 实现
- (void)testWithDispatchgroup{
    static int a = 0;
    BOOL needUserinfo = a++%2;
    
    __block NSString *userinfo;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    if (needUserinfo) {
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            userinfo = @"模拟异步获取到的用户信息";
            dispatch_group_leave(group);
        });
    } else {
        userinfo = @"不需要用户信息";
        dispatch_group_leave(group);
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"用户信息：%@",userinfo);
}


#pragma mark -用 NSOperation 实现
- (void)testWithOperation{
    BOOL needUserinfo = arc4random()%2;
    
    __block NSString *userinfo;
    
    NSOperationQueue *queue = [[LTOperationQueue alloc] init];
    self.queue = queue;
    
    queue.maxConcurrentOperationCount = 10;
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        if (needUserinfo) {
            sleep(2);
            userinfo = @"模拟异步获取到的用户信息";
        } else {
            userinfo = @"不需要用户信息";
        }
        NSLog(@"%@",self);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@ OK!",userinfo);
    }];
    [queue addOperation:op];
//    [op2 addDependency:op];
    [queue addOperation:op2];
}

- (void)dealloc{
    NSLog(@"ddddddd");
}




@end
