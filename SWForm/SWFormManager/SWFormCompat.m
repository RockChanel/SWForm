//
//  SWFormCompat.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormCompat.h"

// 表单标题字体大小
CGFloat const SW_TitleFont = 16.0f;

// 表单详情字体大小
CGFloat const SW_InfoFont = 16.0f;

// 表单条目边缘距离
CGFloat const SW_EdgeMargin = 10.0f;

// 表单标题宽度
CGFloat const SW_TitleWidth = 100.0f;

// 表单标题高度
CGFloat const SW_TitleHeight = 24.0f;

// 表单条目初始高度
CGFloat const SW_DefaultItemHeight = 44.0f;
CGFloat const SW_DefaultTextViewItemHeight = 200.0f;

// 表单标题显示类别
NSInteger const SW_TitleShowType = SWTitleShowTypeRedStarFront;

// 表单输入字数限制
NSInteger const SW_GlobalMaxInputLength = 200;

// 表单选择图片附件数
NSInteger const SW_GlobalMaxImages = 6;

// 表单图片条目图片加载失败占位图
NSString *const SW_PlaceholderImage = @"SWForm.bundle/SWPlaceholderIcon";

inline CGSize SWSizeOfString(NSString *str, CGFloat font, CGSize maxSize) {
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
