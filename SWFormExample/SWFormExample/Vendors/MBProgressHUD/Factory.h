//
//  Factory.h
//  DongDong
//
//  Created by jmsre on 15/11/25.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface Factory : NSObject


// 返回文本size
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font contraint:(CGSize)constraint;


//提示:
+ (void)MBProgressHUD:(NSString *)text Time:(NSUInteger)time;
+ (void)MBProgressHUDUseblock:(void (^)(MBProgressHUD *hud))block;


// 校验手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isChinaMobile:(NSString *)phoneNum;
+ (BOOL)isChinaUnicom:(NSString *)phoneNum;
+ (BOOL)isChinaTelecom:(NSString *)phoneNum;
+ (NSString *)getPhoneNumType:(NSString *)phoneNum;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
