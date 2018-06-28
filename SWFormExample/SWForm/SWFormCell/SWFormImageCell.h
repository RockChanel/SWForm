//
//  SWFormImageCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"

@class SWFormItem;

/**
 图片选择或删除block

 @param images 当前已存在图片数组
 */
typedef void(^SWImageCompletion)(NSArray *images);

/**
 SWFormImageCell 表单图片选择条目
 */
@interface SWFormImageCell : SWFormBaseCell

@property (nonatomic, strong) SWFormItem *item;
@property (nonatomic, copy) SWImageCompletion imageCompletion;

+ (CGFloat)heightWithItem:(SWFormItem *)item;

@end


@interface UITableView (SWFormImageCell)

- (SWFormImageCell *)imageCellWithId:(NSString *)cellId;

@end
