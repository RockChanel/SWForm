//
//  SWFormHandler.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SWFormCompat.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>

@implementation SWFormHandler

+ (instancetype)formHandler {
    return [[self alloc]init];
}

+ (void)sw_handleImageItemWithUrl:(NSURL *)url imageView:(UIImageView *)imageView {
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:SW_PlaceholderImage]];
}

+ (void)sw_handleSelectImageWithCompletion:(void(^)(NSArray *selectImages))completion {
    
}

#pragma mark -- 校验相机相册权限
/** 校验是否有相机权限 */
+ (void)sw_checkCameraAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (videoAuthStatus) {
            // 已授权
        case AVAuthorizationStatusAuthorized:
        {
            permissionGranted(YES);
        }
            break;
            // 未询问用户是否授权
        case AVAuthorizationStatusNotDetermined:
        {
            // 提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                permissionGranted(granted);
            }];
        }
            break;
            // 用户拒绝授权或权限受限
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请在”设置-隐私-相机”选项中，允许访问你的相机" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            permissionGranted(NO);
        }
            break;
        default:
            break;
    }
}

/** 校验是否有相册权限 */
+ (void)sw_checkAlbumAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted {
    
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthStatus) {
            // 已授权
        case PHAuthorizationStatusAuthorized:
        {
            permissionGranted(YES);
        }
            break;
            // 未询问用户是否授权
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                permissionGranted(status == PHAuthorizationStatusAuthorized);
            }];
        }
            break;
            // 用户拒绝授权或权限受限
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请在”设置-隐私-相片”选项中，允许访问你的相册" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            permissionGranted(NO);
        }
            break;
        default:
            break;
    }
    
}

@end
