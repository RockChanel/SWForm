//
//  UIImageView+FormImage.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/31.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "UIImageView+FormImage.h"
#import "SWFormCompat.h"
#import "UIImageView+EMWebCache.h"

@implementation UIImageView (FormImage)


/**
 图片附件条目图片加载
 建议在此使用 SDWebImage
 */
- (void)sw_setImageItemWithUrl:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:SW_PlaceholderImage]];
}

@end
