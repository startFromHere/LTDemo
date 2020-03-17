//
//  LTTipsVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/8/15.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTTipsVC.h"
#import "LTTimer.h"
#import "LTProxy.h"
#import "YYTimer.h"
#import "LTString.h"
#import <malloc/malloc.h>

#define LTTweakUD [NSUserDefaults standardUserDefaults]
#define LTTweakSourceFile(fileName) [NSString stringWithFormat:@"/Library/PreferenceLoader/Preference/lttweakwechat/%@",fileName]

@interface LTTipsVC ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id timer;


@end


@implementation LTTipsVC

//- (NSString *)name{
//    return _name;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.name = @"dd";
    
    UIScrollView *view = ({
        UIScrollView *imgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        imgView.backgroundColor = UIColor.orangeColor;
        imgView.contentSize = CGSizeMake(300, 600);
        imgView;
    });
    [self.view addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAnNotification:) name:@"LTTestNotificationName" object:nil];
}

- (void)receiveAnNotification:(NSNotification *)noti{
    NSLog(@"收到了通知");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
//    [self test];
    [self copyAndMutableCopyTest];
}

#pragma mark -深拷贝和浅拷贝
- (void)copyAndMutableCopyTest{
    
    NSString *str1 = [NSString stringWithFormat:@"%d",arc4random()%2000];
    NSString *str2 = [str1 copy];
    
    LTString *str3 = [LTString new];
    LTString *str4 = [str3 copy];
    
    id obj1 = [NSArray alloc]; // __NSPlacehodlerArray *
    id obj2 = [NSMutableArray alloc];  // __NSPlacehodlerArray *
    id obj3 = [obj1 init];  // __NSArrayI *
    id obj4 = [obj2 init];  // __NSArrayM *
    id obj5 = @{};
    NSObject *oo = [[NSObject alloc] init];
    size_t a = class_getInstanceSize([oo class]);
    size_t b = malloc_size((__bridge const void *)oo);
    
    size_t c = class_getInstanceSize([obj1 class]);
    size_t d = malloc_size((__bridge const void *)obj1);
//    size_t b = malloc_size((__bridge const void *)[[NSObject alloc] init]);
}

- (void)test{
    NSArray *a = @[@"1", @"2", @"3"];
    NSArray *b = a.reverseObjectEnumerator.allObjects;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LTTestNotificationName" object:nil];
    
    [self setLikeClassTest];
    
    
    [self timerTest];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"age:%d", [change[NSKeyValueChangeNewKey] intValue]);
    }
}

- (void)timerTest{
    //1.普通timer
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scheduledTask:) userInfo:nil repeats:YES];
    
    //2.自定义 timer
//    self.timer = [LTTimer timerWithTarget:self task:@selector(scheduledTask:) repeats:YES];
    
    //3.代理
//    LTProxy *proxy = [[LTProxy alloc] initWIthTarget:self];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:proxy selector:@selector(scheduledTask:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //4.nstimer+yyadd
//    __weak typeof(self) weakSelf = self;
//    NSTimer *timer = [YYTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
//        [weakSelf scheduledTask:nil];
//    } repeats:NO];
}

- (void)scheduledTask:(NSTimer *)timer{
    static int a = 0;
    NSLog(@"执行了%d次", ++a);
}

//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//
//    [self.view setFrame:CGRectMake(100, 100, 100, 100)];
//
//}

- (void)viewWillAppear:(BOOL)animated{
    self.view.frame = CGRectMake(0, 0, 200, 300);
    [super viewWillAppear:animated];
}

//集合类的一些操作
- (void)setLikeClassTest{
    NSArray *arr = @[@"hank", @"tom", @"windy", @"jack", @"mary", @"mark", @"hank", @"jim", @"john", @"danny",@"windy"];
    NSMutableArray *personArr = [NSMutableArray array];
    
    NSArray *arr1 = [NSSet setWithArray:arr].allObjects;
    NSString *jointNames = [personArr valueForKeyPath:@"@distinctUnionOfObjects.name"];
    
    NSString *str = (NSString *)[self generateAStr];
}

- (void)blockParamsTest{
    void(^block1)() = ^{
        NSLog(@"this is a block");
    };
    void(^block2)(int a);
    void(^block3)(int a, NSString *b);
    
    void (^block)() = block1;
    
    block(10);
}

- generateAStr{
    return @"dddd";
}

/*分类的属性和子类同名的属性会有冲突吗*/

- (void)dealloc{
//    [[Person sharedPerson] removeObserver:self forKeyPath:@"age"];
}

@end
