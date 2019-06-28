//
//  CopyLabel.h
//  FSIPM
//
//  Created by nickwong on 17/6/3.
//  Copyright © 2017年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CopyLabelStatus) {
    COPY_LABEL                                  //只有复制功能label
};

@interface CopyLabel : UILabel

//创建Label时可根据不同的类型来实现不同的功能
@property (nonatomic, assign) CopyLabelStatus labelType;

@end
