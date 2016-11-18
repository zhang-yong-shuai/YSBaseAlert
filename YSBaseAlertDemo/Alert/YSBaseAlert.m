//
//  YSBaseAlert.m
//  YSBaseAlertDemo
//
//  Created by 张永帅 on 16/3/29.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "YSBaseAlert.h"

CGFloat const kBaseAlertHudAlpha = .3f;

// class property
static UIWindow *__window = nil;

@interface YSBaseAlert ()

@property (nonatomic, strong) UIView *overlayView;

@end

@implementation YSBaseAlert
#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self configureSelf];
    }
    return self;
}

#pragma mark - handle window
- (void)showWindow {
    if (self.window) {
        [self.window makeKeyAndVisible];
    }
}

- (void)dismissWindow {
    if ([self.window isKeyWindow]) {
        [self.window resignKeyWindow];
        __window = nil;
    }
}

#pragma mark - config self
- (void)configureSelf {
    [[self fetchWindow] addSubview:self.overlayView];
    [[self fetchWindow] addSubview:self];
    self.alpha = 0.f;
    self.frame = CGRectMake(100, 100, 200, 200);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6.f;
    self.clipsToBounds = YES;
}

#pragma mark - getters
- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [UIView new];
        _overlayView.frame = [self fetchWindow].bounds;
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.f;
    }
    return _overlayView;
}

- (UIWindow *)fetchWindow {
    if (!__window) {
        __window = [[UIWindow alloc] initWithFrame:YS_SCREEN_BOUNDS];
        __window.backgroundColor = [UIColor clearColor];
        __window.windowLevel = UIWindowLevelAlert;
    }
    return __window;
}

#pragma mark - show / hide
- (void)show {
    [self showWindow];
    YSWeakSelf();
    [UIView animateWithDuration:.2f animations:^{
        weakself.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.f);
        weakself.overlayView.alpha = kBaseAlertHudAlpha;
        weakself.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.14f animations:^{
            weakself.layer.transform = CATransform3DMakeScale(.9f, .9f, 1.f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.2f animations:^{
                weakself.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {}];
        }];
    }];
}

- (void)dismiss {
    YSWeakSelf();
    [UIView animateWithDuration:.1f animations:^{
        weakself.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.15f animations:^{
            weakself.layer.transform = CATransform3DIdentity;
            weakself.overlayView.alpha = 0.f;
            weakself.alpha = 0.f;
        } completion:^(BOOL finished) {
            [weakself dismissWindow];
        }];
    }];
}

@end
