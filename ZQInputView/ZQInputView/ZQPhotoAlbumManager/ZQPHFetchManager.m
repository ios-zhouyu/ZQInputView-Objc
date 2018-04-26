//
//  ZQPHFetchManager.m
//  ZQCameraManager
//
//  Created by zhouyu on 21/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
/*PhotoKit说明--需要获取相机交卷(Camera Roll)里的照片
 PHAsset: 代表照片库中的一个资源，通过 PHAsset 可以获取和保存资源
 PHFetchOptions: 获取资源时的参数，可以传 nil，即使用系统默认值,过滤作用
 PHAssetCollection: PHCollection 的子类，表示一个相册或者一个时刻，或者是一个智能相册
 PHFetchResult: 表示一系列的资源结果集合，也可以是相册的集合，从PHCollection 的类方法中获得
 PHImageManager: 用于处理资源的加载，加载图片的过程带有缓存处理，可以通过传入一个 PHImageRequestOptions 控制资源的输出尺寸等规格
 PHImageRequestOptions: 如上面所说，控制加载图片时的一系列参数
 */

#import "ZQPHFetchManager.h"
#import <Photos/Photos.h>

@implementation ZQPHFetchManager

+ (ZQPHFetchManager *)sharedInstance {
    static ZQPHFetchManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZQPHFetchManager alloc] init];
    });
    return instance;
}

#pragma mark - get all image (从相簙(album)中获取相机交卷相册(PHAssetCollection : Camera Roll),再从相册资源(PHAssetCollection)中输出(PHImageManager)图片(image))
- (NSArray *)getAllPhotosFromPhotoLibrary {
    NSMutableArray *photosArrM = [[NSMutableArray alloc] init];
    //1. 获取相簙所有相册里面的照片资源,使用PHFetchResult对象封装起来,type和subType见最下面注释
    PHFetchResult *fetchResultAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    //2. 遍历PHFetchResult,获取每个相册集合(相机交卷,人物,地点,视频,自拍,屏幕快照,最近删除,其他和自定义相册)
    for (int i = 0; i < fetchResultAlbums.count; i++) {
        PHCollection *collection = fetchResultAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {//
            if ([collection.localizedTitle isEqualToString:@"Camera Roll"]) {//获取相机交卷相册里的照片集合
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                
                //添加过滤条件,筛选出图片,按时间先后顺序
                PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
                fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
                
                //遍历PHFetchResult图片集合,获取图片
                [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
//                    NSLog(@"%@",asset);
                    [photosArrM addObject:asset];
                }];
            }
        }
    }
    return [photosArrM copy];
}

#pragma mark - 触发系统相册权限提示框
- (void)checkFirstUsePhotoKit {
    [PHAssetCollection fetchMomentsWithOptions:nil];
}

@end

/*
 typedef NS_ENUM(NSInteger, PHAssetCollectionType) {
    PHAssetCollectionTypeAlbum      = 1,//从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
    PHAssetCollectionTypeSmartAlbum = 2,//经由相机得来的相册
    PHAssetCollectionTypeMoment     = 3,//Photos 为我们自动生成的时间分组的相册
 }

 typedef NS_ENUM(NSInteger, PHAssetCollectionSubtype) {
    // PHAssetCollectionTypeAlbum regular subtypes
    PHAssetCollectionSubtypeAlbumRegular         = 2,//用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
    PHAssetCollectionSubtypeAlbumSyncedEvent     = 3,//使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。
    PHAssetCollectionSubtypeAlbumSyncedFaces     = 4,//使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
    PHAssetCollectionSubtypeAlbumSyncedAlbum     = 5,//做了 AlbumSyncedEvent 应该做的事
    PHAssetCollectionSubtypeAlbumImported        = 6,//从相机或是外部存储导入的相册

    // PHAssetCollectionTypeAlbum shared subtypes
    PHAssetCollectionSubtypeAlbumMyPhotoStream   = 100,//用户的 iCloud 照片流
    PHAssetCollectionSubtypeAlbumCloudShared     = 101,//用户使用 iCloud 共享的相册

    // PHAssetCollectionTypeSmartAlbum subtypes
    PHAssetCollectionSubtypeSmartAlbumGeneric    = 200,//文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。
    PHAssetCollectionSubtypeSmartAlbumPanoramas  = 201,//相机拍摄的全景照片
    PHAssetCollectionSubtypeSmartAlbumVideos     = 202,//相机拍摄的视频
    PHAssetCollectionSubtypeSmartAlbumFavorites  = 203,//收藏文件夹
    PHAssetCollectionSubtypeSmartAlbumTimelapses = 204,//延时视频文件夹，同时也会出现在视频文件夹中
    PHAssetCollectionSubtypeSmartAlbumAllHidden  = 205,//包含隐藏照片或视频的文件夹
    PHAssetCollectionSubtypeSmartAlbumRecentlyAdded = 206,//相机近期拍摄的照片或视频
    PHAssetCollectionSubtypeSmartAlbumBursts     = 207,//连拍模式拍摄的照片
    PHAssetCollectionSubtypeSmartAlbumSlomoVideos = 208,//Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。
    PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,//相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
    // Used for fetching, if you don't care about the exact subtype
    PHAssetCollectionSubtypeAny = NSIntegerMax //包含所有类型
 }
 */

/*PHAssetCollection.localizedTitle
 Camera Roll : 相机胶卷
 Recently Added : 最近添加
 Recently Deleted : 最近删除
 Videos : 视频
 Slo-mo : 慢动作
 Long Exposure
 Favorites : 个人收藏
 Animated
 Portrait
 Time-lapse
 Live Photos
 Selfies : 自拍
 Bursts : 连拍模式拍摄的照片
 Screenshots : 屏幕快照
 Hidden : 包含隐藏照片或视频的文件夹
 Panoramas : 相机拍摄的全景照片
 All Photos : 所有照片
 */
