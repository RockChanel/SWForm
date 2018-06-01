//
//  SWFormSelectCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"

@class SWFormItem;

/**
 SWFormSelectCell 表单选择条目
 */
@interface SWFormSelectCell : SWFormBaseCell

@property (nonatomic, strong) SWFormItem *item;

+ (CGFloat)heightWithItem:(SWFormItem *)item;

@end


@interface UITableView (SWFormSelectCell)

- (SWFormSelectCell *)selectCellWithId:(NSString *)cellId;

@end
