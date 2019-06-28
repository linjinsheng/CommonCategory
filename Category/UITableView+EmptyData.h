//
//  UITableView+EmptyData.h
//  FSIPM
//
//  Created by nickwong on 16/12/12.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
