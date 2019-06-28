//
//  FSCustomTextField.m
//  FSIPM
//
//  Created by nickwong on 17/5/15.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import "FSCustomTextField.h"

@implementation FSCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.inputAccessoryView = [[FSAccessoryView alloc] initWithDelegate:self];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        self.leftView=leftView;
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

#pragma mark - FSAccessoryViewDelegate Methods

- (void)accessoryViewDidPressedCancelButton:(FSAccessoryView *)view
{
    if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewDidCancelEditing:)])
    {
        [self.textViewDelegate performSelector:@selector(textViewDidCancelEditing:) withObject:self];
    }
    
    [self resignFirstResponder];
}

- (void)accessoryViewDidPressedDoneButton:(FSAccessoryView *)view
{
    if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(textViewDidFinsihEditing:)])
    {
        [self.textViewDelegate performSelector:@selector(textViewDidFinsihEditing:) withObject:self];
    }
    
    [self resignFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))// 允许粘贴
        return YES;
    if (action == @selector(select:))// 允许选择
        return YES;
    if (action == @selector(selectAll:))// 允许全选
        return YES;
    return [super canPerformAction:action withSender:sender];
}



@end
