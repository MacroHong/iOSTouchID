//
//  ViewController.m
//  MHTouchIDDemo
//
//  Created by Macro on 11/7/15.
//  Copyright © 2015 Macro. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"扫描指纹" forState:(UIControlStateNormal)];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}

- (void)btnAction {
    // 初始化上下文
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    // 认证出错时, 在系统弹框中的提示语
    NSString *str = @"请继续扫描你得指纹";
    // 检测设备是否有TouchID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) { // 设备有TouchID
        // 认证成功或失败之前, 会持续进行认证操作
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:str reply:^(BOOL success, NSError *error) {
            if (success) { // TouchID存在, 并认证成功
                NSLog(@"认证成功");
                if (!success) {
                    NSLog(@"%@", error);
                }
            } else { // TouchID存在, 但认证失败
                NSLog(@"认证失败");
                if (!success) {
                    NSLog(@"%@", error);
                }
            }
        }];
    } else { // 设备没有TouchID
        NSLog(@"发生了一个错误");
        if (error) {
            NSLog(@"%@", error);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
