//
//  SWFormHandler.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWFormHandler : NSObject

+ (void)sw_checkCameraAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted;
+ (void)sw_checkAlbumAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted;

@end
