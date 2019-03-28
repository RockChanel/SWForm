//
//  SWFormCompat.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

/**
 SWFormCompat 主要配置表单涉及的相关常量参数，可根据需求修改配置
 */
#import <UIKit/UIKit.h>

/**
 必选条目标题呈现形式类别
 */
typedef NS_ENUM(NSInteger, SWTitleShowType) {
    /**
     默认呈现形式，如: 标题(必填)
     */
    SWTitleShowTypeDefault,
    /**
     标题前部加红色*，如: *标题
     */
    SWTitleShowTypeRedStarFront,
    /**
     标题后部加红色*，如: 标题*
     */
    SWTitleShowTypeRedStarBack,
    /**
     仅显示标题
     */
    SWTitleShowTypeOnlyTitle,
};

/**
 表单标题字体大小，缺省为16
 */
extern CGFloat const SW_TitleFont;

/**
 表单详情字体大小，缺省为16
 */
extern CGFloat const SW_InfoFont;

/**
 表单条目边缘距离，缺省为10.0f
 */
extern CGFloat const SW_EdgeMargin;

/**
 表单标题宽度，缺省为100.0f
 */
extern CGFloat const SW_TitleWidth;

/**
 表单标题高度，缺省为24.0f
 */
extern CGFloat const SW_TitleHeight;

/**
 表单条目初始高度，缺省为44.0f，SWFormItemTypeTextViewInput 类型缺省高度为200，为确保显示正常，设置值>= 44
 */
extern CGFloat const SW_DefaultItemHeight;
extern CGFloat const SW_DefaultTextViewItemHeight;

/**
 表单标题显示类别，缺省为 SWTitleShowTypeRedStarFront
 */
extern NSInteger const SW_TitleShowType;

/**
 表单输入字数限制，缺省为200
 0 表示无限制
 */
extern NSUInteger const SW_GlobalMaxInputLength;

/**
 表单选择图片附件数，缺省为6
 */
extern NSUInteger const SW_GlobalMaxImages;

/**
 表单图片条目图片加载失败占位图
 */
extern NSString *const SW_PlaceholderImage;

/**
 表单附件删除图标
 */
extern NSString *const SW_DeleteIcon;

/**
 表单TextView字数提示文字大小
 */
extern CGFloat const SW_LengHintFont;

/**
 表单条目输入框占位符字体颜色
 */
#define SW_PLACEHOLDERCOLOR [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]

/**
 SWFormItemTypeTextViewInput 类别 TextView 背景颜色
 */
#define SW_TEXTVIEW_BACKGROUNDCOLOR [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0]
/**
 表单条目标题颜色
 */
#define SW_TITLECOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]

/**
 获取屏幕宽度
 */
#define SW_SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width

/// 弱引用
#define SWWeakSelf __weak typeof(self) weakSelf = self;
