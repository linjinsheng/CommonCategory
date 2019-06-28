//
//  CustomTwoTextField.h
//  FSIPM
//
//  Created by nickwong on 17/5/8.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAccessoryView.h"

@protocol CustomTwoTextFieldDelegate;
@interface CustomTwoTextField : UITextField<FSAccessoryViewDelegate>
@property(nonatomic,unsafe_unretained) id<CustomTwoTextFieldDelegate> textViewDelegate;

@end

@protocol CustomTwoTextFieldDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(CustomTwoTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(CustomTwoTextField *)textField; //点击键盘框上的"确认"按钮。

@end
