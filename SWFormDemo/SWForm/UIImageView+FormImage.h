//
//  UIImageView+FormImage.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/31.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片附件加载，去除框架对SDWebImage引用
 */
@interface UIImageView (FormImage)

- (void)sw_setImageItemWithUrl:(NSURL *)url;

@end
