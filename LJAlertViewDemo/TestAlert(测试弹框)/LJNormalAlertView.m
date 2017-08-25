//
//  LJNormalAlertView.m
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import "LJNormalAlertView.h"

@interface LJNormalAlertView ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/**用block进行事件传递*/
@property (nonatomic, copy) void(^(sureBtnClicked))(void);

@end

@implementation LJNormalAlertView
- (IBAction)cancelButtonClicked:(UIButton *)sender {
    //调用父类方法将视图移除
    [self hiddenAlertView];
}
- (IBAction)sureButtonClicked:(UIButton *)sender {
    //传递事件
    if (self.sureBtnClicked) {
        self.sureBtnClicked();
    }
    //调用父类方法将视图移除
    [self hiddenAlertView];
}

/**
 * 展示视图，对视图进行初始化，并对它的参数进行设置
 */
+ (LJNormalAlertView *)showNormalAlertWithContent:(NSString *)content sureBtnClicked:(void (^)(void))sureBtnClicked {
    LJNormalAlertView *normalAlert = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LJNormalAlertView class]) owner:nil options:nil] lastObject];
    //设置frame,可根据content内容进行计算
    normalAlert.frame = CGRectMake(13, ([UIScreen mainScreen].bounds.size.height - 200) / 2.0, [UIScreen mainScreen].bounds.size.width - 26, 200);
    normalAlert.contentLabel.text = content;
    normalAlert.sureBtnClicked = sureBtnClicked;
    //调用父类方法显示视图
    [normalAlert showAlertView];
    return normalAlert;
}

@end
