//
//  UITextView+TextLimit.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "UITextView+TextLimit.h"

@implementation UITextView (TextLimit)

- (void)textLimitWithMaxLength:(NSInteger)maxLength {
    NSString *toBeString = self.text;
    NSArray *inputModes = [UITextInputMode activeInputModes];
    UITextInputMode *currentMode = [inputModes firstObject];
    
    // 输入内容中文校验
    if ([currentMode.primaryLanguage isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > maxLength) {
                self.text = [toBeString substringToIndex:maxLength];
            }
        }
    }
    else{
        if (toBeString.length > maxLength) {
            self.text = [toBeString substringToIndex:maxLength];
        }
    }
}

@end
