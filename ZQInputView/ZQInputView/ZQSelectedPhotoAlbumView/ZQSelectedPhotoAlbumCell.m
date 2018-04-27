//
//  ZQSelectedPhotoAlbumCell.m
//  ZQInputView
//
//  Created by zhouyu on 27/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQSelectedPhotoAlbumCell.h"
#import "Masonry.h"

@interface ZQSelectedPhotoAlbumCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation ZQSelectedPhotoAlbumCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(2.5);
            make.right.mas_equalTo(self).offset(-2.5);
            make.height.width.mas_equalTo(25);
        }];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

#pragma mark - event
- (void)deleteSelectedImage:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletedPhotoAlbumCellWithIndexPaht:)]) {
        [self.delegate deletedPhotoAlbumCellWithIndexPaht:self.indexPath];
    }
}

#pragma mark - getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"image_delete"] forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"image_delete"] forState:UIControlStateSelected];
        [_deleteButton addTarget:self action:@selector(deleteSelectedImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
