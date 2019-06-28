//
//  FSCustomTextField.h
//  FSIPM
//
//  Created by nickwong on 17/5/15.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAccessoryView.h"

@protocol FSTextFiledDelegate;
@interface FSCustomTextField : UITextField<FSAccessoryViewDelegate>
@property(nonatomic,unsafe_unretained) id<FSTextFiledDelegate> textViewDelegate;

@end

@protocol FSTextFiledDelegate <NSObject>

@optional
- (void)textViewDidCancelEditing:(FSCustomTextField *)textField; //点击键盘上的“取消”按钮。
- (void)textViewDidFinsihEditing:(FSCustomTextField *)textField; //点击键盘框上的"确认"按钮。

@end
