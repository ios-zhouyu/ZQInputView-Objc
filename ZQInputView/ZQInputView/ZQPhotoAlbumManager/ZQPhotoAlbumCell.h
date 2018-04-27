//
//  ZQPhotoAlbumCell.h
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

@protocol ZQPhotoAlbumCellDelegate <NSObject>
@optional
- (void)photoAlbumCellSelectedImageWithIndexPath:(NSIndexPath *)indexPath flag:(BOOL)flag;
@end

@interface ZQPhotoAlbumCell : UICollectionViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, weak) id<ZQPhotoAlbumCellDelegate> delegate;

- (void)didDeselectedPhotoAlbumCell;

@end
