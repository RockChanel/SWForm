//
//  SWFormCompat.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 必选条目标题呈现形式类别
 */
typedef NS_ENUM(NSInteger, SWRequriedType) {
    /**
     默认呈现形式，如: 标题(必填)
     */
    SWRequriedTypeDefault,
    /**
     标题前部加红色*，如: *标题
     */
    SWRequriedTypeRedStarFront,
    /**
     标题后部加红色*，如: 标题*
     */
    SWRequriedTypeRedStarBack,
};

/**
 表单标题字体大小
 */
extern CGFloat const SW_TitleFont;

/**
 表单详情字体大小
 */
extern CGFloat const SW_InfoFont;

extern CGFloat const SW_EdgeMargin;
extern CGFloat const SW_TitleWidth;
extern CGFloat const SW_TitleHeight;

extern NSInteger const SW_RequriedType;

#define SW_PLACEHOLDERCOLOR [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]
#define SW_TITLECOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]

#ifndef SW_SCRREN_WIDTH
#define SW_SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
