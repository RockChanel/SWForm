//
//  SWImageCollectionCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SWDeleteImageCompletion)(void);

/**
 表单图片条目图片展示
 */
@interface SWImageCollectionCell : UICollectionViewCell

/**
 当前图片删除操作block
 */
@property (nonatomic, copy) SWDeleteImageCompletion deleteImageCompletion;

/**
 当前图片，支持UIImage、NSURL、NSString(图片URLString)类型
 */
@property (nonatomic, strong) id image;

/**
 当前图片是否可编辑
 */
@property (nonatomic, assign) BOOL editable;

@end
