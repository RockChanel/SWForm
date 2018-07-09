//
//  NSString+SWForm.m
//  SWFormDemo
//
//  Created by zijin on 2018/6/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "NSString+SWForm.h"

@implementation NSString (SWForm)

- (NSString *)addUnit:(NSString *)unit {
    if ([self isEqualToString:@""] || [unit isEqualToString:@""]) {
        return self;
    }
    return [NSString stringWithFormat:@"%@ %@", self, unit];
}

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
