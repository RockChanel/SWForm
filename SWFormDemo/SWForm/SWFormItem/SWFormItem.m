//
//  SWFormItem.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormItem.h"

@implementation SWFormItem

+ (instancetype)item {
    return [[self alloc]init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.defaultHeight = 44.0f;
    }
    return self;
}

@end
