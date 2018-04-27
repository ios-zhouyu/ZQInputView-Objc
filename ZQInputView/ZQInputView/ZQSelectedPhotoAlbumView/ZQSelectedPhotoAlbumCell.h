//
//  ZQSelectedPhotoAlbumCell.h
//  ZQInputView
//
//  Created by zhouyu on 27/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQSelectedPhotoAlbumCellDelegate<NSObject>
@optional
- (void)deletedPhotoAlbumCellWithIndexPaht:(NSIndexPath *)indexPath;
@end

@interface ZQSelectedPhotoAlbumCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<ZQSelectedPhotoAlbumCellDelegate> delegate;

@end
