//
//  SWFormHandler.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 表单系统接口类，针对可独立配置分别处理
 */
@interface SWFormHandler : NSObject

+ (instancetype)formHandler;

/**
 处理附件图片加载，可根据需求配置
 推荐在此使用SDWebImage加载图片URL

 @param url 图片URL
 @param imageView 当前处理的视图
 */
+ (void)sw_handleImageItemWithUrl:(NSURL *)url imageView:(UIImageView *)imageView;

+ (void)sw_handleSelectImageWithCompletion:(void(^)(NSArray *selectImages))completion;

@end
