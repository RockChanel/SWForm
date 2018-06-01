//
//  SWFormImageCell+ImageHandle.m
//  SWFormDemo
//
//  Created by zijin on 2018/6/1.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormImageCell+ImageHandle.h"
#import "SWFormHandler.h"
#import "TZImagePickerController.h"
#import "objc/runtime.h"
#import "MWPhotoBrowser.h"
#import <UIKit/UIKit.h>

static char SW_MAXIMAGECOUNT;
static char SW_CURRENTIMAGECOUNT;
static char SW_SELECTCOMPLETION;
static char SW_BROWSERPHOTOS;

typedef void(^SWSelectImageCompletion)(NSArray *images);

@interface UITableViewCell() <UIActionSheetDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>
@end

@implementation SWFormImageCell (ImageHandle)

- (void)sw_selectImageWithMaxImages:(NSInteger)maxImages currentImages:(NSInteger)currentImages completion:(void(^)(NSArray *selectImages))completion {
    
    [self sw_setMaxImagesCount:maxImages];
    [self sw_setCurrentImagesCount:currentImages];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
    actionSheet.tag = 10;
    [actionSheet showInView:self.superview];
    
    [self sw_setSelectImagesCompletion:completion];
}

#pragma mark -- MWPhotoBrowserDelegate
- (void)sw_photoBrowserWithImages:(NSArray *)images currentIndex:(NSInteger)currentIndex {
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        id object = images[i];
        MWPhoto *photo;
        if ([object isKindOfClass:[UIImage class]]) {
            photo = [MWPhoto photoWithImage:object];
        }
        else if ([object isKindOfClass:[NSURL class]]) {
            photo = [MWPhoto photoWithURL:object];
        }
        else if ([object isKindOfClass:[NSString class]]) {
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:object]];
        }
        if (photo) {
            [photos addObject:photo];
        }
    }
    [self sw_setBrowserPhotos:photos];
    
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    photoBrowser.displayActionButton = YES;
    photoBrowser.displayNavArrows = YES;
    photoBrowser.displaySelectionButtons = NO;
    photoBrowser.alwaysShowControls = NO;
    photoBrowser.zoomPhotosToFill = YES;
    photoBrowser.enableGrid = NO;
    photoBrowser.startOnGrid = NO;
    [photoBrowser setCurrentPhotoIndex:currentIndex];
    
    UINavigationController *photoNavigationController = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
    photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self superViewController:self] presentViewController:photoNavigationController animated:YES completion:nil];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return [self sw_browserPhotos].count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < [self sw_browserPhotos].count) {
        return [[self sw_browserPhotos] objectAtIndex:index];
    }
    return nil;
}

#pragma mark -- 从相册选择图片或者拍照
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 10) {
        switch (buttonIndex) {
            case 0:
            {
                [self takePhoto];
            }
                break;
            case 1:
            {
                [self localPhoto];
            }
                break;
            default:
                break;
        }
    }
}

/**
 拍照
 */
- (void)takePhoto {
    [SWFormHandler sw_checkCameraAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectFromTakePhoto];
            });
        }
    }];
}

/**
 本地相册选择
 */
- (void)localPhoto {
    [SWFormHandler sw_checkAlbumAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectFromLocalPhoto];
            });
        }
    }];
}

- (void)selectFromTakePhoto {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [[self superViewController:self] presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"无法打开照相机,请检查后重试");
    }
}

/** 选取本地图片 */
- (void)selectFromLocalPhoto{
    TZImagePickerController  *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:([self sw_maxImagesCount] - [self sw_currentImagesCount]) delegate:self];
    imagePickerVC.allowPickingVideo = NO;
    if ([self superViewController:self]) {
        [[self superViewController:self] presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selectImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    SWSelectImageCompletion completion = [self sw_selectImagesCompletion];
    if (completion) {
        completion(@[selectImage]);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    SWSelectImageCompletion completion = [self sw_selectImagesCompletion];
    if (completion) {
        completion(photos);
    }
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
