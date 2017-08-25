//
//  ViewController.m
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import "ViewController.h"
#import "LJNormalAlertView.h"
#import "LJTextAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showNormalAlert:(UIButton *)sender {
    [LJNormalAlertView showNormalAlertWithContent:@"每个人都有跟不上这个社会的时候，你是在长牙前，他们是在掉牙后。" sureBtnClicked:^{
        NSLog(@"---确定---");
    }];
}

- (IBAction)showTextAlert:(UIButton *)sender {
    [LJTextAlertView showTextAlertSureBtnClicked:^(NSString *inputText) {
        NSLog(@"%@",inputText);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
