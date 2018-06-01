//
//  SWFormImageCell+ImageHandle.h
//  SWFormDemo
//
//  Created by zijin on 2018/6/1.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormImageCell.h"

@interface SWFormImageCell (ImageHandle)

/**
 选择图片数据回调
 
 @param maxImages 最大可选择图片数
 @param currentImages 当前选择图片数
 @param completion 选择图片数组回调
 */
- (void)sw_selectImageWithMaxImages:(NSInteger)maxImages currentImages:(NSInteger)currentImages completion:(void(^)(NSArray *selectImages))completion;

/**
 图片浏览

 @param images 图片数组
 @param currentIndex 当前浏览的index
 */
- (void)sw_photoBrowserWithImages:(NSArray *)images currentIndex:(NSInteger)currentIndex;


@end
