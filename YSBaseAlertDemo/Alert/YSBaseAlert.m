//
//  YSBaseAlert.m
//  YSBaseAlertDemo
//
//  Created by 张永帅 on 16/3/29.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "YSBaseAlert.h"


@interface YSBaseAlert ()

/// alert background view
@property (nonatomic, strong) UIView *alertView;

/// hud view
@property (nonatomic, strong) UIView *overlayView;

@end

@implementation YSBaseAlert

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self configureSelf];
    }
    return self;
}

#pragma mark - config self
- (void)configureSelf {
    self.backgroundColor = [UIColor clearColor];
    [self insertSubview:self.overlayView belowSubview:self.alertView];
}

#pragma mark - getters
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [UIView new];
        [self addSubview:_alertView];
        _alertView.frame = self.frame;
        _alertView.alpha = 0.f;
        _alertView.clipsToBounds = NO;
        _alertView.layer.backgroundColor = [[UIColor colorWithWhite:1 alpha:1.f] CGColor];
        _alertView.layer.cornerRadius = 10.f;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = .5f;
    }
    return _overlayView;
}

#pragma mark - show / hide
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window bringSubviewToFront:self];
    YSWeakSelf();
    [UIView animateWithDuration:.2f animations:^{
        weakself.alertView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.f);
        weakself.alertView.alpha = 1.f;
        weakself.overlayView.alpha = .5f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.14f animations:^{
            weakself.alertView.layer.transform = CATransform3DMakeScale(.9f, .9f, 1.f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.2f animations:^{
                weakself.alertView.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {}];
        }];
    }];
}

- (void)dismiss {
    YSWeakSelf();
    [UIView animateWithDuration:.1f animations:^{
        weakself.alertView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.15f animations:^{
            weakself.alertView.layer.transform = CATransform3DIdentity;
            weakself.alertView.alpha = 0.f;
            weakself.overlayView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [weakself removeFromSuperview];
        }];
    }];
}

@end
