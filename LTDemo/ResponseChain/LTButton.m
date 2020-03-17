//
//  LTButton.m
//  LTDemo
//
//  Created by 刘涛 on 2019/7/22.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "LTButton.h"

@implementation LTButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"button 响应了touch事件");
}


@end
