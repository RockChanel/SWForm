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
@property (nonatomic, assign) SWFormItemType itemType;

/**
 表单条目标题，表单标题为单行显示，尽可能简短，若标题太长，会牺牲字体大小以达到显示完全的效果
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSAttributedString *attributedTitle;

/**
 表单条目详情
 */
@property (nonatomic, copy) NSString *info;

/**
 表单条目错误信息，用于表单条件未满足时快捷错误提示
 */
@property (nonatomic, copy) NSString *error;

/**
 表单条目占位字符
 */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

/**
 图片附件条目图片
 */
@property (nonatomic, strong) NSArray *images;

/**
 表单条目键盘类型
 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/**
 表单条目是否可编辑 YES:可编辑 NO:不可编辑
 */
@property (nonatomic, assign) BOOL editable;

/**
 表单条目是否必填(必选) YES:必填(必选) NO:可填(可选)
 */
@property (nonatomic, assign) BOOL required;

@end


/**
 SWFormItemMake 快捷构建新增表单条目
 */
FOUNDATION_EXPORT SWFormItem *SWFormItem_Add(NSString *title, NSString *info, SWFormItemType itemType, BOOL editable, BOOL required, UIKeyboardType keyboardType);

/**
 SWFormItemMake 快捷构建详情表单条目
 */
FOUNDATION_EXPORT SWFormItem *SWFormItem_Info(NSString *title, NSString *info, SWFormItemType itemType);
