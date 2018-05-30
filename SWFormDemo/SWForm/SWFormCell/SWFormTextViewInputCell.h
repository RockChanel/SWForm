//
//  SWFormTextViewInputCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"

@class SWFormItem;

typedef void(^TextViewInputCompletion)(NSString *text);

@interface SWFormTextViewInputCell : SWFormBaseCell

@property (nonatomic, strong) SWFormItem *item;
@property (nonatomic, copy) TextViewInputCompletion textViewInputCompletion;

+ (CGFloat)heightWithItem:(SWFormItem *)item;

@end


@interface UITableView (SWFormTextViewInputCell)

- (SWFormTextViewInputCell *)textViewInputCellWithId:(NSString *)cellId;

@end
