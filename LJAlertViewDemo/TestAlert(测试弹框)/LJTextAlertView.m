//
//  LJTextAlertView.m
//  LJAlertViewDemo
//
//  Created by 技术部 on 17/8/25.
//  Copyright © 2017年 Mr Luo. All rights reserved.
//

#import "LJTextAlertView.h"

@interface LJTextAlertView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

/**用block进行事件传递*/
@property (nonatomic, copy) void(^(sureBtnClicked))(NSString *inpurText);

@end

@implementation LJTextAlertView

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    [self.textView resignFirstResponder];
    //调用父类方法将视图移除
    [self hiddenAlertView];
}

- (IBAction)sureButtonClicked:(UIButton *)sender {
    [self.textView resignFirstResponder];
    if (self.sureBtnClicked) {
        self.sureBtnClicked(self.textView.text);
    }
    //调用父类方法将视图移除
    [self hiddenAlertView];
}

/**
 * 使用该方法展示视图，初始化视图，设置参数等
 */
+ (LJTextAlertView *)showTextAlertSureBtnClicked:(void (^)(NSString *))sureBtnClicked {
    LJTextAlertView *textAlert = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LJTextAlertView class]) owner:nil options:nil] lastObject];
    textAlert.textView.delegate = textAlert;
    //设置frame
    textAlert.frame = CGRectMake(13, ([UIScreen mainScreen].bounds.size.height - 200) / 2.0, [UIScreen mainScreen].bounds.size.width - 26, 200);
    textAlert.sureBtnClicked = sureBtnClicked;
    //调用父类方法添加键盘事件
    [textAlert addKeyborder];
    [textAlert showAlertView];
    return textAlert;
}

#pragma mark text view delegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }else {
        self.placeholderLabel.hidden = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}



@end
