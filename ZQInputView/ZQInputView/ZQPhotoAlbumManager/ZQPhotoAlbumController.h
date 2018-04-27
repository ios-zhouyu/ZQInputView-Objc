//
//  ZQPhotoAlbumController.h
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQPhotoAlbumControllerDelegate <NSObject>
@optional
- (void)photoAlbumControllerSelectedPhotoAlbumArr:(NSArray *)selectedPhotoAlbumArr;
@end

@interface ZQPhotoAlbumController : UIViewController
@property (nonatomic, weak) id<ZQPhotoAlbumControllerDelegate> delegate;
@end
