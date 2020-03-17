//
//  ZGAddressInfoTextField.m
//  FinancialExam
//
//  Created by 刘涛 on 2019/6/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "ZGAddressInfoTextField.h"
#import <UIColor+WHColor.h>

@interface ZGAddressInfoTextField ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSString *originalTxt;

@end

@implementation ZGAddressInfoTextField

- (instancetype)init{
    if (self = [super init]) {
        [self configSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithTitle:(NSString *)title content:(NSString *)content placeholder:(NSString *)placeholder{
    
    self.placeholder = placeholder;
    
    UILabel *titleLabel = (UILabel *)self.titleLabel;
    titleLabel.text = title;
    
    if (content.length == 0) {
        self.textView.textColor =  [UIColor colorFromHexRGB:@"0xaaaaaa"];
        self.textView.text = placeholder;
    } else {
        self.textView.textColor =  [UIColor colorFromHexRGB:@"0x666666"];
        self.textView.text = content;
    }
    
    [self adjustTextViewHeightIfNeeded];
    
//    if (!IsEmptyString(content)) {
//        self.text = content;
//        self.enabled = NO;
//    } else {
//        self.enabled = YES;
//    }
}

- (void)configSubviews{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorFromHexRGB:@"0x333333"];
    titleLabel.font = [UIFont systemFontOfSize:15];
//    titleLabel.frame = CGRectMake(ZGPhysicLengthFromUI(30), 0, ZGPhysicLengthFromUI(170), ZGPhysicLengthFromUI(94));
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(ZGPhysicLengthFromUI(170));
        make.height.mas_equalTo(ZGPhysicLengthFromUI(94));
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
    [self addSubview:self.textView];
    
    self.closureIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wd_icon_jth"] highlightedImage:[UIImage imageNamed:@"wd_icon_jt"]];
    [self addSubview:_closureIndicator];
    [_closureIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-ZGPhysicLengthFromUI(30));
        make.centerY.mas_equalTo(self);
    }];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = [UIColor colorFromHexRGB:@"0xdfdfdf"];
    [self addSubview:_bottomLine];
    [_bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(.5);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(ZGPhysicLengthFromUI(170));
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(floor(ZGPhysicLengthFromUI(476)));
        make.height.mas_equalTo(ZGPhysicLengthFromUI(94));
    }];
    
    //默认隐藏右侧箭头和底部分割线
    self.closureIndicator.hidden = YES;
    self.bottomLine.hidden = YES;
}

- (void)cancelEdit{
//    self.text = self.originalTxt;
//    self.enabled = NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:self.placeholder]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor colorFromHexRGB:@"0x666666"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSMutableString *tobeStr = [textView.text mutableCopy];
    if (range.location + range.length <= tobeStr.length) {
        [tobeStr replaceCharactersInRange:range withString:text];
    } else {
        [tobeStr appendString:text];
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    [self adjustTextViewHeightIfNeeded];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = self.placeholder;
        textView.textColor = [UIColor colorFromHexRGB:@"0xaaaaaa"];
    }
//    [self adjustTextViewHeightIfNeeded];
}

- (void)adjustTextViewHeightIfNeeded{
    CGFloat textviewWidth = floor(ZGPhysicLengthFromUI(476));
    
    //单行文字高度
    CGFloat singleLineTxtHeight = [self.textView.text boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _textView.font} context:nil].size.height;
    CGFloat textPadding = (ZGPhysicLengthFromUI(94) - singleLineTxtHeight) / 2;
    
    //实际文字高度
    CGFloat textHeight = [self.textView.text boundingRectWithSize: CGSizeMake(textviewWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _textView.font} context:nil].size.height;
    
    //textview 高度
    CGFloat textViewHeight = MAX(ZGPhysicLengthFromUI(94), textHeight + 2 * textPadding );
    
    if (self.textView.textContainer.lineFragmentPadding > 0) {
        self.textView.textContainerInset = UIEdgeInsetsMake(textPadding, 0, 0, 0);
        self.textView.textContainer.lineFragmentPadding = 0;
    }
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textViewHeight);
    }];
}

@end
