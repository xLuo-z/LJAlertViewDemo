//
//  LJBaseAlertView.h
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 所有自定义弹框视图的基类,当要创建弹框视图的时候，以它为基类创建，然后视图初始化后，调用它的方法显示和隐藏视图
 */

@interface LJBaseAlertView : UIView

/**
 * 以下方法在父类实现，给子类调用
 */

/*!
 @brief 添加键盘监听事件，当用到输入框的弹框的时候，子类需要调用
 */
- (void) addKeyborder;

/*!
 @brief 展示当前的视图，把展示动画封装在父视图里面，方便子类调用，当要改变动画效果的时候，可以在这个方法修改
 */
- (void) showAlertView;

/*!
 @brief 方法作用和上面一个方法相同，增加了一个视图显示完成的回调
 @param complete 视图显示完成回调
 */
- (void) showAlertViewComplete:(void(^)(void))complete;

/*!
 @brief 隐藏视图（将视图移除父视图），也是将隐藏动画封装在父视图，子类需要直接调用，需要修改隐藏动画的时候直接在该方法修改
 */
- (void) hiddenAlertView;


/*!
 @brief 移除背景视图的点击手势，默认背景视图有点击效果，点击背景，弹框视图消失，调用该方法可以取消该点击效果
 */
- (void) removeBgViewTapEvent;


@end
