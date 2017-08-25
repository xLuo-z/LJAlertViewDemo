//
//  LJBaseAlertView.m
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import "LJBaseAlertView.h"

@interface LJBaseAlertView (){
    //背景视图点击手势
    UITapGestureRecognizer *tap ;
}

/**背景视图*/
@property (nonatomic, strong) UIView *bgView;

/**应用keywindow*/
@property (nonatomic, strong) UIWindow *keyWindow;

@end

@implementation LJBaseAlertView

/**
 * 由xib创建的视图调用该方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self privateInit];
    }
    return self;
}

/**
 * 代码传入frame创建调用该方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self privateInit];
    }
    return self;
}

#pragma mark private init 
/**
 * 私有初始化方法，进行背景，window等的初始化工作
 */
- (void) privateInit {
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [self.keyWindow addSubview:self.bgView];
    
    //手势添加
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAlertView)];
    [self.bgView addGestureRecognizer:tap];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

#pragma mark 以下是供子类调用的方法的实现
/**
 * 添加键盘监听事件
 */
- (void)addKeyborder {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyborderShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyborderHidden:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 * 展示视图
 */
- (void)showAlertView {
    [self showAlertViewComplete:nil];
}

/**
 * 展示视图完成并回调
 */
- (void)showAlertViewComplete:(void (^)(void))complete {
    [self.keyWindow addSubview:self];
    self.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(1.2,1.2);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        weakSelf.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
    }];
}

/**
 * 隐藏视图（将试图重父视图移除）
 */
- (void)hiddenAlertView {
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
    }completion:^(BOOL finished) {
        [weakSelf.bgView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

/**
 * 去掉背景视图的点击效果
 */
- (void)removeBgViewTapEvent {
    [self.bgView removeGestureRecognizer:tap];
}

#pragma mark 键盘监听事件实现
/**
 * 键盘将要出现
 */
- (void) keyborderShow:(NSNotification *)not {
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [not.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //获取键盘frame
    CGRect keybordRect = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect = CGRectIntersection(keybordRect, self.frame);
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration animations:^{
        weakSelf.center = CGPointMake(weakSelf.center.x, weakSelf.center.y - (rect.size.height));
    }];
}

/**
 * 键盘将要消失
 */
- (void) keyborderHidden:(NSNotification *)not {
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [not.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration animations:^{
        //键盘收起，视图位置复原
        weakSelf.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - weakSelf.frame.size.width) / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0 - weakSelf.frame.size.height / 2.0, weakSelf.frame.size.width, weakSelf.frame.size.height);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
