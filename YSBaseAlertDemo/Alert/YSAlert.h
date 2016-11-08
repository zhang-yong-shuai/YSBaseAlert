//
//  YSBAlert.h
//  YSBaseAlertDemo
//
//  Created by 张永帅 on 15/8/26.
//  Copyright (c) 2015年 张永帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBaseAlert.h"

@interface YSAlert : YSBaseAlert

@property (nonatomic, readonly) UILabel *messageLabel;
@property (nonatomic, copy) void (^leftButtonAction)();
@property (nonatomic, copy) void (^rightButtonAction)();

// 初始化方法
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle;

@end
