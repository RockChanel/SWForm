//
//  SWFormItem.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormItem.h"
#import "SWFormCompat.h"

@interface SWFormItem()

+ (instancetype)sw_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(SWFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType;

+ (instancetype)sw_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(SWFormItemType)itemType;

@end

inline SWFormItem *SWFormItem_Add(NSString *title, NSString *info, SWFormItemType itemType, BOOL editable, BOOL required, UIKeyboardType keyboardType) {
    return [SWFormItem sw_itemWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType];
}

inline SWFormItem *SWFormItem_Info(NSString *title, NSString *info, SWFormItemType itemType) {
    return [SWFormItem sw_itemWithTitle:title info:info itemType:itemType];
}

@implementation SWFormItem

+ (instancetype)sw_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(SWFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType images:nil showPlaceholder:YES];
}

+ (instancetype)sw_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(SWFormItemType)itemType {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:NO required:NO keyboardType:UIKeyboardTypeDefault images:nil showPlaceholder:NO];
}

- (instancetype)initWithTitle:(NSString *)title info:(NSString *)info itemType:(SWFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType images:(NSArray *)images showPlaceholder:(BOOL)showPlaceholder{
    self = [super init];
    if (self) {
        self.maxInputLength = SW_GlobalMaxInputLength;
        self.maxImageCount = SW_GlobalMaxImages;
        self.title = title;
        self.info = info;
        self.itemType = itemType;
        self.editable = editable;
        self.required = required;
        self.keyboardType = keyboardType;
        self.images = images;
        self.showPlaceholder = showPlaceholder;
        [self sw_setDefaultHeight:itemType];
        [self sw_setPlaceholderWithShow:showPlaceholder itemType:itemType];
        [self sw_setAttributedTitleWithRequired:required title:title itemType:itemType];
    }
    return self;
}


/**
 根据表单条目类型设置条目缺省高度
 */
- (void)sw_setDefaultHeight:(SWFormItemType)itemType {
    self.defaultHeight = itemType == SWFormItemTypeTextViewInput ? SW_DefaultTextViewItemHeight:SW_DefaultItemHeight;
}

/**
 设置是否显示输入框占位字符
 */
- (void)sw_setPlaceholderWithShow:(BOOL)show itemType:(SWFormItemType)itemType {
    if (!show) {
        self.placeholder = @"";
        return;
    }
    switch (itemType) {
        case SWFormItemTypeInput:
        case SWFormItemTypeTextViewInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        case SWFormItemTypeSelect:
        {
            self.placeholder = @"请选择";
        }
            break;
            
        default:
            self.placeholder = @"";
            break;
    }
}

- (void)sw_setAttributedTitleWithRequired:(BOOL)required title:(NSString *)title itemType:(SWFormItemType)itemType{
    if (required) {
        if (SW_TitleShowType == SWTitleShowTypeDefault) {
            switch (self.itemType) {
                case SWFormItemTypeInput:
                case SWFormItemTypeTextViewInput:
                {
                    title = [NSString stringWithFormat:@"%@(必填)", title];
                }
                    break;
                case SWFormItemTypeSelect:
                case SWFormItemTypeImage:
                {
                    title = [NSString stringWithFormat:@"%@(必选)", title];
                }
                    break;
                default:
                    break;
            }
        }
        else if (SW_TitleShowType == SWTitleShowTypeRedStarFront) {
            title = [NSString stringWithFormat:@"*%@", title];
        }
        else if (SW_TitleShowType == SWTitleShowTypeRedStarBack) {
            title = [NSString stringWithFormat:@"%@*", title];
        }
    }
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SW_TitleFont], NSForegroundColorAttributeName:SW_TITLECOLOR}];
    
    if (required) {
        if (SW_TitleShowType == SWTitleShowTypeRedStarFront) {
            [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        }
        else if (SW_TitleShowType == SWTitleShowTypeRedStarBack) {
            [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(title.length - 1, 1)];
        }
    }
    self.attributedTitle = attributedTitle;
}

#pragma mark -- 重写get方法
- (NSArray *)selectImages {
    NSMutableArray *tempImages = [NSMutableArray array];
    for (id temp in self.images) {
        if ([temp isKindOfClass:[UIImage class]]) {
            [tempImages addObject:temp];
        }
    }
    return tempImages;
}

#pragma mark -- 重写属性set方法，防止单独改变属性无响应效果
- (void)setImages:(NSArray *)images {
    _images = images;
    [self selectImages];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self sw_setAttributedTitleWithRequired:self.required title:title itemType:self.itemType];
}

- (void)setRequired:(BOOL)required {
    _required = required;
    [self sw_setAttributedTitleWithRequired:required title:self.title itemType:self.itemType];
}

- (void)setItemType:(SWFormItemType)itemType {
    _itemType = itemType;
    [self sw_setDefaultHeight:itemType];
    [self sw_setAttributedTitleWithRequired:self.required title:self.title itemType:itemType];
    [self sw_setPlaceholderWithShow:self.showPlaceholder itemType:itemType];
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder {
    _showPlaceholder = showPlaceholder;
    [self sw_setPlaceholderWithShow:showPlaceholder itemType:self.itemType];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SW_InfoFont],NSForegroundColorAttributeName:SW_PLACEHOLDERCOLOR}];
    self.attributedPlaceholder = attributedPlaceholder;
}

@end
