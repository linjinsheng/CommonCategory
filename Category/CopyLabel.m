//
//  CopyLabel.m
//  FSIPM
//
//  Created by nickwong on 17/6/3.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import "CopyLabel.h"

@implementation CopyLabel

//  通过正常创建的初始化方法，绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

//为了能接收到事件（能成为第一响应者），我们需要覆盖一个方法：
-(BOOL)canBecomeFirstResponder{
    return YES;
}

// 可以响应的方法
//此方法中只相应了复制和粘贴两个方法，也就是弹出的面板中只有复制和粘贴两个按钮。
//其它方法都返回No代表禁止，面板内不会出现相应的按钮。
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    switch (self.labelType) {
        case COPY_LABEL:
            //只允许复制操作
            return (action == @selector(copy:));
            break;
        default:
            break;
    }
    //其它操作不允许
    return NO;
}

//针对于响应方法的实现,点击copy按钮时调用此方法
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//有了以上三个方法，我们就能处理copy和paste了，当然，在能接收到事件的情况下：
//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:longPress];
}

//接下来，我们需要处理这个tap，以便让菜单栏弹出来：
-(void)handleTap:(UIGestureRecognizer*) recognizer{
    //if判断是为了保证长按手势只执行一次
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
    }
}

@end


//case COPY_PASTE_LABEL:
////允许复制操作、粘贴操作
//if (action == @selector(paste:)) {
//    return (action == @selector(paste:));
//}else if (action == @selector(copy:)){
//    return (action == @selector(copy:));
//}
//break;

////针对于响应方法的实现,点击paste按钮时调用此方法
//-(void)paste:(id)sender{
//    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    self.text = pboard.string;
//}

