//
//  UITabBar+FSCustomBadge.m
//  FSIPM
//
//  Created by Eddy on 16/8/10.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import "UITabBar+FSCustomBadge.h"
#import <objc/runtime.h>

static NSString * const kCustomBadgeValueKey = @"CustomBadgeValueKey";
static NSInteger const kCustomBadgeTag = 6666;
static NSInteger const kTaBarItemCount = 4;

@implementation UITabBar (FSCustomBadge)

- (NSString *)customBadgeValue
{
    return objc_getAssociatedObject(self, &kCustomBadgeValueKey);
}

- (void)setCustomBadgeValue:(NSString *)customBadgeValue
{
    objc_removeAssociatedObjects(self);
    objc_setAssociatedObject(self, &kCustomBadgeValueKey, customBadgeValue, OBJC_ASSOCIATION_COPY);
}

- (void)showBadgeOnItemIndex:(int)index badgeValue:(NSInteger)badgeValue
{
    if (badgeValue <= 0)
    {
        
        FSLog(@"没有数值则返回");
        return;
    }
    
    NSString *badgeString = [NSString stringWithFormat:@"%ld",badgeValue];
    FSLog(@"显示小红点数值为%@",badgeString);
    
    if (badgeValue > 99)
    {
         badgeString = @"99+";
    }
    
    self.customBadgeValue = badgeString;
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / kTaBarItemCount;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);

    UIImageView *badgeImageView = (UIImageView *)[self viewWithTag:kCustomBadgeTag + index];
    
    if (badgeImageView != nil)
    {
        [badgeImageView removeFromSuperview];
    }
    
    badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 10, 10)];
    [badgeImageView setTag:kCustomBadgeTag + index];
    [badgeImageView setBackgroundColor:[UIColor redColor]];
    
    [self addSubview:badgeImageView];
    
    NSLog(@"%@",badgeImageView);
    
    UILabel *badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [badgeLabel setFont:[UIFont systemFontOfSize:12]];
    [badgeLabel setText:badgeString];
    [badgeLabel setTextColor:[UIColor whiteColor]];
    [badgeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [badgeLabel sizeToFit];
    badgeLabel.frame = CGRectMake(badgeLabel.frame.origin.x,
                                  badgeLabel.frame.origin.y,
                                  badgeLabel.frame.size.width + 10,
                                  18);
    
    if (badgeLabel.width < badgeLabel.height)
    {
        badgeLabel.width = badgeLabel.height;
    }
    
    
    [badgeImageView.layer setCornerRadius:badgeImageView.height/2.0];
    [badgeImageView.layer setMasksToBounds:YES];
    
}

- (void)hideBadgeOnItemIndex:(int)index
{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index
{
    //按照tag值进行移除
    for (UIView *subView in self.subviews)
    {
        if (subView.tag == kCustomBadgeTag + index)
        {
            [subView removeFromSuperview];
        }
    }
}


@end
