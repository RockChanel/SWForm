//
//  SWFormSectionItem.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWFormSectionItem : NSObject

/**
 表单每个Section包含的条目集合
 */
@property (nonatomic, strong) NSArray *items;

@end

FOUNDATION_EXPORT SWFormSectionItem *SWSectionItem(NSArray *items);
