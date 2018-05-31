//
//  UITableViewCell+SelectImage.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/31.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 旨在暴露接口，实现高度可定制化，去除框架对图片选择库以及预览库的限制
 可在此文件根据需求进行定制化配置，根据需求选用图片选择库、图片预览库等
 */
@interface UITableViewCell (SelectImage)

/**
 选择图片数据回调

 @param maxImages 最大可选择图片数
 @param currentImages 当前选择图片数
 @param completion 选择图片数组回调
 */
- (void)sw_selectImageWithMaxImages:(NSInteger)maxImages currentImages:(NSInteger)currentImages completion:(void(^)(NSArray *selectImages))completion;

@end
