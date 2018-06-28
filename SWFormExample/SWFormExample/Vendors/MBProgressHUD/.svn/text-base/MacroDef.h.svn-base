//
//  MacroDef.h
//  DongDong
//
//  Created by jmsre on 15/11/25.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#ifndef MacroDef_h
#define MacroDef_h



//数据存储
#define UserDefaultsGet(Key)           [[NSUserDefaults standardUserDefaults] objectForKey:Key]
#define UserDefaultsSave(Value,Key)    {[[NSUserDefaults standardUserDefaults] setObject:Value forKey:Key]; [[NSUserDefaults standardUserDefaults] synchronize];}
#define UserDefaultsRemove(Key)        [[NSUserDefaults standardUserDefaults] removeObjectForKey:Key]

// IOS 版本
#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

//View相关
#define Point(Xpos, Ypos)                  CGPointMake(Xpos, Ypos)
#define Size(Width, Height)                CGSizeMake(Width, Height)
#define Frame(Xpos, Ypos, Width, Height)   CGRectMake(Xpos, Ypos, Width, Height)
#define Xpos                               origin.x
#define Ypos                               origin.y
#define Width                              size.width
#define Height                             size.height


//Window相关
#define Screen_Width                 [UIScreen mainScreen].bounds.size.width
#define Screen_Height                [UIScreen mainScreen].bounds.size.height

//设置View圆角
#define setViewCorner(view,radius)   {view.layer.cornerRadius = radius; view.layer.masksToBounds = YES;}

//设置颜色
#define ColorRGBA(R,G,B,A)           [UIColor colorWithRed:R / 255.0 green:G / 255.0  blue:B / 255.0  alpha:A]
#define ColorRGB(R,G,B)              [UIColor colorWithRed:R / 255.0 green:G / 255.0  blue:B / 255.0  alpha:1.0]

//透明色
#define ClearColor                   [UIColor clearColor]

//字体
#define Font(FontSize)                     [UIFont systemFontOfSize:FontSize]
#define BoldFont(FontSize)                 [UIFont boldSystemFontOfSize:FontSize]

//变量属性
#define Strong          @property(nonatomic, strong)
#define Weak            @property(nonatomic, weak)
#define Retain          @property(nonatomic, retain)
#define Copy            @property(nonatomic, copy)
#define Assign          @property(nonatomic, assign)

#define StrongWithIB    @property(nonatomic, strong) IBOutlet
#define WeakWithIB      @property(nonatomic, weak) IBOutlet
#define RetainWithIB    @property(nonatomic, retain) IBOutlet

//block self
#define WeakSelf        __weak typeof(self) wself = self;


#define iPhone5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6p    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) : NO)


//泛型转换成NSString
#define StringFromId(idType)  [NSString stringWithFormat:@"%@",idType]

//整形转换成NSString
#define StringFromInt(idType)  [NSString stringWithFormat:@"%ld",idType]


//explant
// RGB的颜色方法
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kUIColorFromRGBA(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define UI_MAIN_COLOR             [UIColor colorWithRed:0.733 green:0.655 blue:0.424 alpha:1.000]

#define YDScreenWidth             [UIScreen mainScreen].bounds.size.width
#define YDScreenHeight            [UIScreen mainScreen].bounds.size.height
//#define Width YDScreenWidth/YDScreenHeight
#define YDBackGroundColor         kUIColorFromRGB(0xf0f0f0)
#define YDTableSeperateLineColor  kUIColorFromRGB(0xe1e1e1)
#define YDRedColor                kUIColorFromRGB(0xe40000)
#define YDYellowColor             kUIColorFromRGB(0xf2bd57)

#define YDAlert(message)         [[[UIAlertView alloc]initWithTitle:nil message:message \
delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil, nil]show]


#endif /* MacroDef_h */
