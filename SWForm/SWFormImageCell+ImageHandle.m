//
//  SWFormImageCell+ImageHandle.m
//  SWFormDemo
//
//  Created by zijin on 2018/6/1.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormImageCell+ImageHandle.h"
#import "objc/runtime.h"

static char SW_MAXIMAGECOUNT;
static char SW_CURRENTIMAGECOUNT;
static char SW_SELECTCOMPLETION;
static char SW_BROWSERPHOTOS;

typedef void(^SWSelectImageCompletion)(NSArray *images);

@interface UITableViewCell()
@end

@implementation SWFormImageCell (ImageHandle)

- (void)sw_selectImageWithMaxImages:(NSInteger)maxImages currentImages:(NSInteger)currentImages completion:(void(^)(NSArray *selectImages))completion {
    
    [self sw_setMaxImagesCount:maxImages];
    [self sw_setCurrentImagesCount:currentImages];
    [self sw_setSelectImagesCompletion:completion];
}

- (void)sw_photoBrowserWithImages:(NSArray *)images currentIndex:(NSInteger)currentIndex {

}

#pragma mark -- 设置图片选择block
- (void)sw_setSelectImagesCompletion:(SWSelectImageCompletion)completion {
    objc_setAssociatedObject(self, &SW_SELECTCOMPLETION, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SWSelectImageCompletion)sw_selectImagesCompletion {
    return objc_getAssociatedObject(self, &SW_SELECTCOMPLETION);
}

#pragma mark -- 设置当前获取的图片
- (void)sw_setBrowserPhotos:(NSArray *)photos {
    objc_setAssociatedObject(self, &SW_BROWSERPHOTOS, photos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)sw_browserPhotos {
    return objc_getAssociatedObject(self, &SW_BROWSERPHOTOS);
}

#pragma mark -- 设置最大图片数
- (void)sw_setMaxImagesCount:(NSInteger)count {
    objc_setAssociatedObject(self, &SW_MAXIMAGECOUNT, @(count), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)sw_maxImagesCount {
    return [objc_getAssociatedObject(self, &SW_MAXIMAGECOUNT) integerValue];
}

#pragma mark -- 设置当前图片数
- (void)sw_setCurrentImagesCount:(NSInteger)count {
    objc_setAssociatedObject(self, &SW_CURRENTIMAGECOUNT, @(count), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)sw_currentImagesCount {
    return [objc_getAssociatedObject(self, &SW_CURRENTIMAGECOUNT) integerValue];
}

#pragma mark -- 获取当前View所在的ViewController
- (UIViewController *)superViewController:(UIView *)view{
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    return nil;
}

@end
