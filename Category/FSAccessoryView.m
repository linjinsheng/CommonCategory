//
//  FSAccessoryView.m
//  FSIPM
//
//  Created by nickwong on 17/5/15.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import "FSAccessoryView.h"

@interface FSAccessoryView ()
{
    UILabel *_titleLabel;
}
@property (nonatomic, unsafe_unretained) id<FSAccessoryViewDelegate> accessoryDelegate;
@end

@implementation FSAccessoryView

- (id)initWithDelegate:(id<FSAccessoryViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.accessoryDelegate = delegate;
        self.frame = CGRectMake(0, 0, FSScreenWidth, 44);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0, 0, 44, 44)];
        [btn addTarget:self action:@selector(inputCancel) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithCustomView:btn];
        
        _titleLabel = [[UILabel alloc]
                       initWithFrame:(CGRect){
                           44,
                           0,
                           FSScreenWidth-44*2-44,
                           44}];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                          initWithCustomView:_titleLabel];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [doneBtn setFrame:CGRectMake(100, 0, 44, 44)];
        [doneBtn addTarget:self action:@selector(inputDone) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithCustomView:doneBtn];
        
        self.items = @[cancelButton,flexibleSpace,doneButton];
        self.barStyle = UIBarStyleDefault;
        self.translucent = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [_titleLabel setText:title];
}

- (void)inputCancel{
    if (_accessoryDelegate && [_accessoryDelegate
                               respondsToSelector:@selector(accessoryViewDidPressedCancelButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedCancelButton:self];
    }
}

- (void)inputDone{
    if (_accessoryDelegate && [_accessoryDelegate
                               respondsToSelector:@selector(accessoryViewDidPressedDoneButton:)]) {
        [_accessoryDelegate accessoryViewDidPressedDoneButton:self];
    }
}


@end
