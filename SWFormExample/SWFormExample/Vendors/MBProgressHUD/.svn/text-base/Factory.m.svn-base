//
//  Factory.m
//  DongDong
//
//  Created by jmsre on 15/11/25.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "Factory.h"
#import "MacroDef.h"

@implementation Factory


// 返回文本size
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font contraint:(CGSize)constraint{
    CGSize size = CGSizeZero;
    if (IOS7_OR_LATER)
    {
        size = [text boundingRectWithSize:constraint
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                               attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
                                  context:nil].size;
    }
//    else
//    {
//        size = [text sizeWithFont:font constrainedToSize:constraint
//                    lineBreakMode:NSLineBreakByWordWrapping];
//    }
    return size;
}

//提示:
+ (void)MBProgressHUD:(NSString *)text Time:(NSUInteger)time{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].windows[0]];
    [[UIApplication sharedApplication].windows[0] addSubview:HUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    __block unsigned int  tttt = (unsigned int)time;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(tttt);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

+ (void)MBProgressHUDUseblock:(void (^)(MBProgressHUD *hud))block{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].windows[0]];
    [[UIApplication sharedApplication].windows[0] addSubview:HUD];
    HUD.labelText = @"正在加载...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(1);
        dispatch_sync(dispatch_get_main_queue(), ^{
            block(HUD);
        });
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}


// 校验手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isChinaMobile:(NSString *)phoneNum
{
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}

+ (BOOL)isChinaUnicom:(NSString *)phoneNum
{
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    return [regextestcu evaluateWithObject:phoneNum];
}

+ (BOOL)isChinaTelecom:(NSString *)phoneNum
{
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    return [regextestct evaluateWithObject:phoneNum];
}

+ (NSString *)getPhoneNumType:(NSString *)phoneNum
{
    return [self isChinaMobile:phoneNum]? @"中国移动": ([self isChinaUnicom:phoneNum]? @"中国联通":([self isChinaTelecom:phoneNum]? @"中国电信": @"未知"));
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

@end
