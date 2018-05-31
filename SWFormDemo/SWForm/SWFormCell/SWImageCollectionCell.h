//
//  SWImageCollectionCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 当前图片删除操作block
 */
typedef void(^SWDeleteImageCompletion)(void);

@interface SWImageCollectionCell : UICollectionViewCell

@property (nonatomic, copy) SWDeleteImageCompletion deleteImageCompletion;

/**
 当前图片，支持UIImage、NSURL、NSString(图片URLString)类型
 */
@property (nonatomic, strong) id image;
@property (nonatomic, assign) BOOL editable;

@end
