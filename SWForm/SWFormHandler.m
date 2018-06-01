//
//  SWFormHandler.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormHandler.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <UIKit/UIKit.h>
#import "SWFormItem.h"
#import "SWFormSectionItem.h"

@implementation SWFormHandler

+ (void)sw_checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure {
    for (int sec = 0; sec < datas.count; sec++) {
        SWFormSectionItem *sectionItem = datas[sec];
        for (int row = 0; row < sectionItem.items.count; row++) {
            SWFormItem *rowItem = sectionItem.items[row];
            if (rowItem.required) {
                if (rowItem.itemType == SWFormItemTypeInput || rowItem.itemType == SWFormItemTypeTextViewInput) {
                    if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                        failure([NSString stringWithFormat:@"请输入%@", rowItem.title]);
                        return;
                    }
                }
                else if (rowItem.itemType == SWFormItemTypeSelect) {
                    if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                        failure([NSString stringWithFormat:@"请选择%@", rowItem.title]);
                        return;
                    }
                }
                else if (rowItem.itemType == SWFormItemTypeImage) {
                    if (!rowItem.images || rowItem.images.count == 0) {
                        failure([NSString stringWithFormat:@"请选择%@", rowItem.title]);
                        return;
                    }
                }
            }
        }
    }
    success();
}

#pragma mark -- 校验相机相册权限
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
