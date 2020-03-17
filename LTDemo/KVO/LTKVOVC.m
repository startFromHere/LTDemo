//
//  LTKVOVC.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/1.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTKVOVC.h"
#import "LTObject.h"

@interface LTKVOVC ()

@end

@implementation LTKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    LTObject *obj = [[LTObject alloc] init];
    [obj addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
    obj.num = @1;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change:%@",change);
}

@end
