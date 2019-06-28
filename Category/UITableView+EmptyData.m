//
//  UITableView+EmptyData.m
//  FSIPM
//
//  Created by nickwong on 16/12/12.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        
        UIView *wholeView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FSScreenWidth, FSScreenHeight)];
        self.backgroundView = wholeView;
        
        CGFloat imgW = 220;
        CGFloat imgH = 115;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-imgW*0.5, self.center.y-imgH,imgW, imgH)];
        imageView.image = [UIImage imageNamed:@"Empty"];
        [wholeView addSubview:imageView];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 15, self.frame.size.width, 15)];
        messageLabel.text = message;;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor lightGrayColor];
        [wholeView addSubview:messageLabel];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
