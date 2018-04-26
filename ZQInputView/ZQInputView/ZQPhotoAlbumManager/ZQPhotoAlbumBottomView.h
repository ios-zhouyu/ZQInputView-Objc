//
//  ZQAllImageBottomView.h
//  ZQCameraManager
//
//  Created by zhouyu on 21/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQPhotoAlbumBottomViewDelegate <NSObject>
@optional
- (void)photoAlbumBottomViewCertainButtonClick;
- (void)photoAlbumBottomViewPreviewButtonClick;
@end

@interface ZQPhotoAlbumBottomView : UIView
@property (nonatomic, strong) UIButton *previewButton;//预览
@property (nonatomic, strong) UIButton *certainButton;//确认
@property (nonatomic, strong) UILabel *tipLabel;//提示

@property (nonatomic, weak) id<ZQPhotoAlbumBottomViewDelegate> delegate;

@end
