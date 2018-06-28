//
//  SWFormItem.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SWFormItem;

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

typedef NS_ENUM(NSInteger, SWFormItemUnitType) {
    SWFormItemUnitTypeNone = 0, // 无单位
    SWFormItemUnitTypeYuan, // 元
    SWFormItemUnitTypeYear, // 年
    SWFormItemUnitTypeMillion, // 万元
    SWFormItemUnitTypeCustom, // 自定义单位
};

typedef void(^SWItemSelectCompletion)(SWFormItem *item);

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
@property (nonatomic, copy, nonnull) NSString *title;
@property (nonatomic, strong, nonnull) NSAttributedString *attributedTitle;

/**
 表单条目详情
 */
@property (nonatomic, copy, nullable) NSString *info;

/**
 表单条目占位字符
 */
@property (nonatomic, copy, nullable) NSString *placeholder;
@property (nonatomic, strong, nullable) NSAttributedString *attributedPlaceholder;

/**
 是否显示表单条目占位字符 YES:显示 NO:不显示 --- 新增 default is YES；详情 default is NO
 */
@property (nonatomic, assign) BOOL showPlaceholder;

/**
 图片附件条目图片数组，支持UIImage、NSURL、NSString(图片URLString)类型元素
 */
@property (nonatomic, strong, nullable) NSArray *images;

/**
 images 图片数组中类型筛选出为UIImage的数组子集，以实现图片上传筛选
 */
@property (nonatomic, strong, readonly) NSArray *selectImages;

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

/**
 SWFormItemTypeInput 以及 SWFormItemTypeTextViewInput 类别中表示最大输入字数
 0 表示无限制
 */
@property (nonatomic, assign) NSUInteger maxInputLength;

/**
 SWFormItemTypeImage 类别中表示最大选择图片数
 */
@property (nonatomic, assign) NSUInteger maxImageCount;

/**
 表单条目点击选择事件block
 */
@property (nonatomic, copy, nullable) SWItemSelectCompletion itemSelectCompletion;

/**
 条目附带单位
 */
@property (nonatomic, copy, nullable) NSString *unit;

/**
 表单条目单位类别
 */
@property (nonatomic, assign) SWFormItemUnitType itemUnitType;

/**
 是否显示当前字数
 只在 SWFormItemTypeTextViewInput 类型下有效，若无最大字数限制，则只显示字数； 若有字数限制，则显示 "当前字数/最大字数"
 */
@property (nonatomic, assign) BOOL showLength;

@end

/**
 SWFormItem_Add 快捷构建新增表单条目

 @param title 标题
 @param info 详情
 @param itemType 条目类别
 @param editable 是否可编辑
 @param required 是否必填
 @param keyboardType 键盘类别
 */
FOUNDATION_EXPORT SWFormItem *SWFormItem_Add(NSString * _Nonnull title, NSString * _Nullable info, SWFormItemType itemType, BOOL editable, BOOL required, UIKeyboardType keyboardType);

/**
 SWFormItem_Info 快捷构建详情表单条目
 */
FOUNDATION_EXPORT SWFormItem *SWFormItem_Info(NSString * _Nonnull title, NSString * _Nullable info, SWFormItemType itemType);
