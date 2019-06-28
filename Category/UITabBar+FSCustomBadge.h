//
//  UITabBar+FSCustomBadge.h
//  FSIPM
//
//  Created by Eddy on 16/8/10.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (FSCustomBadge)

@property (nonatomic, copy) NSString *customBadgeValue;

- (void)showBadgeOnItemIndex:(int)index badgeValue:(NSInteger)badgeValue;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
