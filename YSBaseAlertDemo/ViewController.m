//
//  ViewController.m
//  YSBaseAlertDemo
//
//  Created by zys on 2016/11/7.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "ViewController.h"
#import "YSAlert.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show alert" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (void)showAlert {
    YSAlert *alert = [[YSAlert alloc] initWithTitle:nil message:@"This is a alert!" leftButtonTitle:@"ok" rightButtonTitle:@"cancel"];
    [alert show];
}

@end
