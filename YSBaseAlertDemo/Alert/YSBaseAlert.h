//
//  YSBaseAlert.h
//  YSBaseAlertDemo
//
//  Created by 张永帅 on 16/3/29.
//  Copyright © 2016年 张永帅. All rights reserved.
//

/**
 *  所有自定义alert的基类，负责弹出和收起alert，其他功能由子类完成
 *  思路：初始化时将alert（自己）加到window上；show函数显示window；dismiss函数去除window
 */

#import <UIKit/UIKit.h>

#define YSWeakSelf() __weak typeof(self) weakself = self
#define YS_SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define YS_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define YS_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface YSBaseAlert : UIView

- (void)show;
- (void)dismiss;

@end
