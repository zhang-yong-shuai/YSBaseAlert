//
//  YSBAlert.m
//  YSBaseAlertDemo
//
//  Created by 张永帅 on 15/8/26.
//  Copyright (c) 2015年 张永帅. All rights reserved.
//

#import "YSAlert.h"
#import "Masonry.h"

CGFloat const kYSAlertButtonHeight = 55.f;

#define kYSAlertWidth (YS_SCREEN_WIDTH * .7f)
#define kYSAlertMsgWidth (kYSAlertWidth - 30.f)
#define kYSAlertMsgMaxHeight (YS_SCREEN_HEIGHT / 2.f)

@interface YSAlert ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation YSAlert

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle {
    if (self = [super init]) {
        [self placeSubviews];
        [self fillDataWithTiltle:title message:message leftButtonTitle:leftButtonTitle andRightButtonTitle:rightButtonTitle];
    }
    
    return self;
}

#pragma mark - fill data
- (void)fillDataWithTiltle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle andRightButtonTitle:(NSString *)rightButtonTitle {
    if (title && title.length > 0) {
        self.titleLabel.text = title;
    } else {
        self.titleLabel.text = @"";
        
        // update frame
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@0.f);
        }];
    }
    
    if (message && message.length > 0) {
        self.messageLabel.text = message;
        
        // update frame
        CGRect messageFrame = [message boundingRectWithSize:CGSizeMake(kYSAlertMsgWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.messageLabel.font} context:nil];
        
        CGFloat messageHeight = messageFrame.size.height + 2.f;
        
        // set max height
        if (messageHeight >= kYSAlertMsgMaxHeight) {
            messageHeight = kYSAlertMsgMaxHeight;
        }
        
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(messageHeight));
        }];
    }
    
    if (leftButtonTitle && leftButtonTitle.length > 0) {
        [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    }
    
    if (rightButtonTitle && rightButtonTitle.length > 0) {
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    }
}

#pragma mark - layout
- (void)placeSubviews {
    // 布局
    YSWeakSelf();

    // alertview
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself);
        make.centerY.equalTo(weakself).offset(-50.f);
        make.bottom.equalTo(weakself.leftButton);
        make.width.equalTo(@(kYSAlertWidth));
    }];
    
    // 标题
    CGFloat titleHeight = [@"温馨提示" sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].height;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.alertView).offset(20.f);
        make.left.right.equalTo(weakself.alertView);
        make.height.equalTo(@(titleHeight));
    }];
    
    // 内容
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(10.f);
        make.left.equalTo(weakself.alertView).offset(15.f);
        make.right.equalTo(weakself.alertView).offset(-15.f);
        make.height.equalTo(@50.f);
    }];
    
    // separate line
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.right.equalTo(weakself.alertView);
        make.bottom.equalTo(weakself.leftButton.mas_top);
        make.height.equalTo(@.5f);
    }];
    
    // 左侧按钮
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.messageLabel.mas_bottom).offset(30.0);
        make.left.equalTo(weakself.alertView);
        make.right.equalTo(weakself.alertView.mas_centerX);
        make.height.equalTo(@(kYSAlertButtonHeight));
    }];
    
    // 右侧按钮
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(weakself.leftButton);
        make.left.equalTo(weakself.alertView.mas_centerX);
        make.right.equalTo(weakself.alertView);
    }];
}


#pragma mark - getters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.alertView addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        [self.alertView addSubview:_messageLabel];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:18];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messageLabel;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [UIView new];
        [self.alertView addSubview:_separateLine];
        _separateLine.backgroundColor = [UIColor greenColor];
    }
    
    return _separateLine;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alertView addSubview:_leftButton];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _leftButton.backgroundColor = [UIColor clearColor];
        [_leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alertView addSubview:_rightButton];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _rightButton.backgroundColor = [UIColor greenColor];
        [_rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightButton;
}

#pragma mark - show / hide
- (void)leftButtonClicked:(UIButton *)button {
    [self dismiss];
    
    if (self.leftButtonAction) {
        self.leftButtonAction();
    }
}

- (void)rightButtonClicked:(UIButton *)button {
    [self dismiss];
    
    if (self.rightButtonAction) {
        self.rightButtonAction();
    }
}

@end
