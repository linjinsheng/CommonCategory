//
//  Tools.h
//  FSIPM
//
//  Created by nickwong on 16/4/27.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

/**
 * HUD
 */
+ (void)showTipsWithHUD:(NSString *)labelText showTime:(CGFloat)time;

/**
 * 只有换行
 */
+ (BOOL)onlyNewLine:(NSString *)text;


/**
 *是否表情
 */
+ (BOOL) isContainsEmoji:(NSString *)string;

/**
 * 手机号码验证
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 * 密码验证
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/**
 * 邮箱验证
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 * 昵称
 */
+ (BOOL)validateNickname:(NSString *)nickname;

/**
 * 根据十六进字符获得颜色
 */
+(UIColor *) getColor:(NSString *)hexColor isSingleColor:(BOOL)isSingleColor;

/**
 * 获取当前时间
 */
+ (NSString *)getCurTime;

/**
 * 在加密前获取标识
 */
+ (NSString *)getSignBeforeMD5:(NSString *)time;

/**
 * md5加密
 */
+ (NSString *)md5HexDigest:(NSString*)input;

/**
 * 设备
 */
+ (NSString *)getPlatform;

/**
 * 颜色转图片
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;

/**
 * 隐藏多余的分割线
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

@end
