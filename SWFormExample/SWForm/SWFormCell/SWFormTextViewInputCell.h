//
//  SWFormTextViewInputCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"

@class SWFormItem;

typedef void(^SWTextViewInputCompletion)(NSString *text);

/**
 SWFormTextViewInputCell 表单输入条目，标题居上，详情居下，支持单行与多行输入
 */
@interface SWFormTextViewInputCell : SWFormBaseCell

@property (nonatomic, strong) SWFormItem *item;
@property (nonatomic, copy) SWTextViewInputCompletion textViewInputCompletion;

+ (CGFloat)heightWithItem:(SWFormItem *)item;

@end


@interface UITableView (SWFormTextViewInputCell)

- (SWFormTextViewInputCell *)textViewInputCellWithId:(NSString *)cellId;

@end
