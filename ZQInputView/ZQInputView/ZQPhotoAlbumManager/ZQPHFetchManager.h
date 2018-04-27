//
//  ZQPHFetchManager.h
//  ZQCameraManager
//
//  Created by zhouyu on 21/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PHAsset, UIImage;

typedef NS_ENUM(NSInteger, ZQAssetMediaType) {
    ZQAssetMediaTypeUnknown,//未知
    ZQAssetMediaTypeImage,//图片
    ZQAssetMediaTypeVideo,//视频
    ZQAssetMediaTypeAudio//音频
};

@interface ZQPHFetchManager : NSObject

+ (ZQPHFetchManager *)sharedInstance;

//唯一作用,简单调用任意一个PhotoKit的api,触发系统访问相册权限的alert弹框,防止首次获取系统照片事件被alert弹框阻断,获取不到照片
- (void)checkFirstUsePhotoKit;

//获取所有照片
- (NSArray *)getAllPhotosFromPhotoLibrary;

//获取已选择PHAsset集合中的原始图片
- (NSArray<UIImage *> *)getSelectedPhotosImageWithSelectedAssetArr:(NSArray<PHAsset *> *)selectedAssetArr;

//冲PHAsset中获取单张图片
- (UIImage *)getPhotoImageWithAsset:(PHAsset *)asset imageSize:(CGSize)imageSize;

@end
