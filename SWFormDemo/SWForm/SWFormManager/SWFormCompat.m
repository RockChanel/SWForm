//
//  SWFormCompat.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormCompat.h"

CGFloat const SW_TitleFont = 16.0f;

CGFloat const SW_InfoFont = 16.0f;

CGFloat const SW_EdgeMargin = 10.0f;

CGFloat const SW_TitleWidth = 100.0f;

CGFloat const SW_TitleHeight = 24.0f;

CGFloat const SW_DefaultItemHeight = 44.0f;
CGFloat const SW_DefaultTextViewItemHeight = 200.0f;

NSInteger const SW_TitleShowType = SWTitleShowTypeRedStarFront;

NSInteger const SW_GlobalMaxInputLength = 200;

NSInteger const SW_GlobalMaxImages = 6;

NSString *const SW_PlaceholderImage = @"";

inline CGSize SWSizeOfString(NSString *str, CGFloat font, CGSize maxSize) {
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
