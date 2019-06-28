//
//  Tools.m
//  FSIPM
//
//  Created by nickwong on 16/4/27.
//  Copyright © 2016年 nickwong. All rights reserved.
//

#import "Tools.h"

@implementation Tools

//HUD
+ (void)showTipsWithHUD:(NSString *)labelText showTime:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]] ;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.labelFont = [UIFont systemFontOfSize:16.0];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hide:YES afterDelay:time];
}

//只有换行
+ (BOOL)onlyNewLine:(NSString *)text
{
    return [[text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length] == 0;
}

//是否表情
+ (BOOL) isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b)
             {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSString *phoneRegex = @"^((13[0-9])|(17[0])|(17[7])|(14[57])|(15[012356789])|(17[678])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
}

//密码验证
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,15}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//邮箱验证
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//昵称
+ (BOOL)validateNickname:(NSString *)nickname;
{
    NSString *engStr = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{2,30}";
    
    NSPredicate *engPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",engStr];
    return [engPre evaluateWithObject:nickname];
}

//根据十六进字符获得颜色
+(UIColor *) getColor:(NSString *)hexColor isSingleColor:(BOOL)isSingleColor
{
    if ([hexColor isEqualToString:@""]||hexColor == nil) {
        return [UIColor blackColor];
    }
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    if (isSingleColor) {
        return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
    }
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:0.90f];
}

//获取当前时间
+ (NSString *)getCurTime
{
    NSTimeInterval curTime = [[NSDate date]timeIntervalSince1970];
    NSString *timeS = [NSString stringWithFormat:@"%.3f",curTime];
    NSMutableString *time = [NSMutableString stringWithString:timeS];
    [time deleteCharactersInRange:[timeS rangeOfString:@"."]];
    return time;
}

//在加密前获取标识
+ (NSString *)getSignBeforeMD5:(NSString *)time
{
    NSMutableString *sign = [[NSMutableString alloc]init];
    [sign appendString:@"ios"];
    [sign appendString:@"id="];
    [sign appendString:time];
    //[sign appendString:@"bc005d648c2769b3d728fb8"];
    [sign appendString:@"8693af6762ad44e98352591dbaceb6f2"];
    
    return sign;
}

//md5加密
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

// 设备
+ (NSString *)getPlatform
{
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = (char*)malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    NSLog(@"platform -- %@",platform);
//    free(machine);
    
    //iPhone
//    if ([platform isEqualToString:@"iPhone1,1"])   platform = @"iPhone 1G";
//    if ([platform isEqualToString:@"iPhone1,2"])   platform = @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"])   platform = @"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"])   platform = @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,2"])   platform = @"Verizon iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"])   platform = @"iPhone 4 (CDMA)";
//    if ([platform isEqualToString:@"iPhone4,1"])   platform = @"iPhone 4s";
//    if ([platform isEqualToString:@"iPhone5,1"])   platform = @"iPhone 5 (GSM/WCDMA)";
//    if ([platform isEqualToString:@"iPhone5,2"])   platform = @"iPhone 5 (CDMA)";
//    if ([platform isEqualToString:@"iPhone6,1"])   platform = @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone6,2"])   platform = @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone7,1"])   platform = @"iPhone 6 plus";
//    if ([platform isEqualToString:@"iPhone7,2"])   platform = @"iPhone 6";
//    if ([platform isEqualToString:@"i386"])        platform = @"iPhone Simulator";
//    if ([platform isEqualToString:@"x86_64"])      platform = @"iPhone Simulator";
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    return platform;
}

/**
 *颜色值转换成图片
 */

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//隐藏多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
