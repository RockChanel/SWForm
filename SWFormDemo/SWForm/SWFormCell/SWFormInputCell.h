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
 SWFormInputCell 表单输入条目，标题居左，详情居右，支持单行与多行输入
 */
@interface SWFormInputCell : SWFormBaseCell

@property (nonatomic, strong) SWFormItem *item;

@end


/**
 SWFormInputCell 对于UITableView的分类，实现SWFormInputCell初始化
 */
@interface UITableView (SWFormInputCell)

- (SWFormInputCell *)inputCellWithId:(NSString *)cellId;

@end
