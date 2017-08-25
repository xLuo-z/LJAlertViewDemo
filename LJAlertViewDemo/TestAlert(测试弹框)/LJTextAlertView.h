//
//  LJTextAlertView.h
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import "LJBaseAlertView.h"

/**
 * 带输入框的自定义弹框视图
 */

@interface LJTextAlertView : LJBaseAlertView

/*!
 @brief 使用类方法展示该视图，并通过block回调将操作结果放回
 @param sureBtnClicked 确定按钮点击回调，取消按钮没有回调，需要可以在后面添加
 @return 返回创建的视图，有利于进行方法迭代
 */
+ (LJTextAlertView *)showTextAlertSureBtnClicked:(void(^)(NSString *inputText))sureBtnClicked;

@end
