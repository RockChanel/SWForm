//
//  SWFormSectionItem.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormSectionItem.h"

@interface SWFormSectionItem()

+ (instancetype)sw_sectionItem:(NSArray *)items;

@end

inline SWFormSectionItem *SWSectionItem(NSArray * _Nonnull items) {
    return [SWFormSectionItem sw_sectionItem:items];
}

@implementation SWFormSectionItem

+ (instancetype)sw_sectionItem:(NSArray *)items {
    return [[self alloc]initWithItems:items];
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

@end
