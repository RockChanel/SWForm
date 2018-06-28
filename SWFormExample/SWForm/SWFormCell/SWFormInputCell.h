//
//  SWFormInputCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"

@class SWFormItem;

/**
 输入内容block

 @param text 当前输入内容
 */
typedef void(^SWInputCompletion)(NSString *text);

/**
 SWFormInputCell 表单输入条目，标题居左，详情居右，支持单行与多行输入
 */
@interface SWFormInputCell : SWFormBaseCell

/**
 条目配置参数
 */
@property (nonatomic, strong) SWFormItem *item;

@property (nonatomic, copy) SWInputCompletion inputCompletion;

/**
 获取条目高度
 */
+ (CGFloat)heightWithItem:(SWFormItem *)item;

@end


/**
 SWFormInputCell 对于UITableView的分类，实现SWFormInputCell初始化
 */
@interface UITableView (SWFormInputCell)

- (SWFormInputCell *)inputCellWithId:(NSString *)cellId;

@end
