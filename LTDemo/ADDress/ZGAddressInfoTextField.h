//
//  ZGAddressInfoTextField.h
//  FinancialExam
//
//  Created by 刘涛 on 2019/6/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGAddressInfoTextField : UIView

@property (nonatomic, strong) UIImageView *closureIndicator;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) NSString *placeholder;

- (void)configWithTitle:(NSString *)title content:(NSString *)content placeholder:(NSString *)placeholder;

/**
 取消编辑
 */
- (void)cancelEdit;

@end

NS_ASSUME_NONNULL_END
