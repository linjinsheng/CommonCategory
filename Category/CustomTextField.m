//
//  CustomTextField.m
//  IPMProjectDemo
//
//  Created by nickwong on 15/12/16.
//  Copyright © 2015年 nickwong. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

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
    if (action == @selector(paste:))//允许粘贴
        return YES;
    if (action == @selector(select:))// 允许选择
        return YES;
    if (action == @selector(selectAll:))// 允许全选
        return YES;
    return [super canPerformAction:action withSender:sender];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

//控制placeHolder的位置，左右缩10
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds, 10, 0 );
}

//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - 40, bounds.origin.y + bounds.size.height -32, 20, 20);
}

@end

