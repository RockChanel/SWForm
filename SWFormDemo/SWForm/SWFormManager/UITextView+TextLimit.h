//
//  UITextView+TextLimit.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TextLimit)

/**
 TextView 添加字数限制

 @param maxLength 限制字数
 */
- (void)textLimitWithMaxLength:(NSInteger)maxLength;

@end
