# SWForm

>详细说明戳这里：[iOS 高度封装自适应表单(重构版)](https://www.jianshu.com/p/2d2f742622fa)

![image](https://github.com/RockChanel/SWGIF/blob/master/SWForm/SWForm.gif)

![image](https://github.com/RockChanel/SWGIF/blob/master/SWForm/SWForm_1.png)

`SWForm` 旨在快捷构建表单系统框架，支持大部分表单系统所需条目样式，且包含了图片附件、编辑、新增、详情等功能的拓展.

### 使用方式

使用 `SWForm` 框架只需将 `SWForm`文件夹导入项目中，将所有可定制化配置的接口都已经统一入口，方便使用者根据自身需求实现定制化功能.

本项目中提供了所有定制化接口的示例 `SWFormDemo`，以作为参考。

<br/>

`SWForm` 根据需求提供了三个接口文件，以方便使用者实现高度定制化，分别为 `UIImageView+FormImage`、`SWFormImageCell+ImageHandle`、`SWFormHandler`.

<br/>

`UIImageView+FormImage` 针对表单图片条目图片加载提供接口:
```objective-c
- (void)sw_setImageItemWithUrl:(NSURL *)url;
```
<br/>

`SWFormImageCell+ImageHandle` 提供图片添加接口以及图片预览接口，使用者可以在此接口添加自定义图片选择以及图片预览功能:
```objective-c
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
```

<br/>

`SWFormHandler` 为数据校验文件，提供了相机权限、相册权限以及表单空数据校验功能:
```objective-c
/**
 必选(必填)数据空数据校验，可根据需求定制

 @param datas 表单数据源
 @param success 必选(必填)数据全部校验成功
 @param failure 必选(必填)数据某一项校验失败
 */
+ (void)sw_checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure;

/**
 校验是否有相机权限
 */
+ (void)sw_checkCameraAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted;

/**
 校验是否有相册权限
 */
+ (void)sw_checkAlbumAuthorizationStatusWithGrand:(void(^)(BOOL granted))permissionGranted;
```
