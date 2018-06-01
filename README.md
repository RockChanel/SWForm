# SWForm

`SWForm` 旨在快捷构建表单系统框架，支持大部分表单系统所需条目样式，且包含了图片附件、编辑、新增、详情等功能的拓展.

### 使用方式

使用 `SWForm` 框架只需将 `SWForm`文件夹导入项目中，将所有可定制化配置的接口都已经统一入口，方便使用者根据自身需求实现定制化功能.

本项目中提供了所有定制化接口的示例 `SWFormDemo`，以作为参考，在下载项目之后，使用者需执行以下命令:
```
cd 下载路径/SWForm-master/SWFormDemo/
pod install
```
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
