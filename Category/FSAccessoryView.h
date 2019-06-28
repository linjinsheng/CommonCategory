//
//  FSAccessoryView.h
//  FSIPM
//
//  Created by nickwong on 17/5/15.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FSAccessoryViewDelegate;

@interface FSAccessoryView : UIToolbar
- (id)initWithDelegate:(id<FSAccessoryViewDelegate>)delegate;
- (void)setTitle:(NSString *)title;

@end

@protocol FSAccessoryViewDelegate <NSObject>
@optional
- (void)accessoryViewDidPressedCancelButton:(FSAccessoryView *)view;
- (void)accessoryViewDidPressedDoneButton:(FSAccessoryView *)view;

@end
