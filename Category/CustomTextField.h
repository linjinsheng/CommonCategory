//
//  CustomTextField.h
//  IPMProjectDemo
//
//  Created by nickwong on 15/12/16.
//  Copyright © 2015年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAccessoryView.h"

@protocol CustomTextFieldDelegate;
@interface CustomTextField : UITextField<FSAccessoryViewDelegate>
@property(nonatomic,unsafe_unretained) id<CustomTextFieldDelegate> textViewDelegate;

@end

@protocol CustomTextFieldDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(CustomTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(CustomTextField *)textField; //点击键盘框上的"确认"按钮。

@end
