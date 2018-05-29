//
//  SWFormItem.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SWFormItemType) {
    /**
     表单条目可单行或多行输入（标题居左）
     */
    SWFormItemTypeInput = 0,
    /**
     表单条目可选择（标题居左）
     */
    SWFormItemTypeSelect = 1,
    /**
     表单条目可多行输入（标题居上）
     */
    SWFormItemTypeTextViewInput = 2,
    /**
     表单条目包含图片选择
     */
    SWFormItemTypeImage = 3,
};

/**
 SWFormItem 主要对表单条目提供动态配置属性
 */
@interface SWFormItem : NSObject

/**
 表单条目缺省高度，缺省值为44.0f, 可根据需求设置
 */
@property (nonatomic, assign) CGFloat defaultHeight;

/**
 表单条目类型
 */
@property (nonatomic, assign) SWFormItemType type;

/**
 表单条目标题
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *placeholder;

/**
 创建并返回 SWFormItem 对象
 */
+ (instancetype)item;

@end
