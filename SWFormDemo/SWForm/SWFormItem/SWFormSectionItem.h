//
//  SWFormSectionItem.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/29.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SWFormSectionItem : NSObject

/**
 表单每个Section包含的条目集合
 */
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

FOUNDATION_EXPORT SWFormSectionItem *SWSectionItem(NSArray *items);
