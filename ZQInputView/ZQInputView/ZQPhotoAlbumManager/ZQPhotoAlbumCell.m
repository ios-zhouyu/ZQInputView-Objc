//
//  ZQPhotoAlbumCell.m
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQPhotoAlbumCell.h"
#import "Masonry.h"
#import "ZQPHFetchManager.h"

@interface ZQPhotoAlbumCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *selectButton;
@end

@implementation ZQPhotoAlbumCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.selectButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.right.mas_equalTo(self).offset(-5);
            make.height.width.mas_equalTo(30);
        }];
    }
    return self;
}

- (void)didDeselectedPhotoAlbumCell {
    self.selectButton.selected = NO;
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    self.imageView.image = [[ZQPHFetchManager sharedInstance] getPhotoImageWithAsset:asset imageSize:CGSizeMake(350, 350)];
}

- (void)selectedImage:(UIButton *)button {
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoAlbumCellSelectedImageWithIndexPath:flag:)]) {
        [self.delegate photoAlbumCellSelectedImageWithIndexPath:self.indexPath flag:button.selected];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        [_selectButton setImage:[UIImage imageNamed:@"photo_normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"photo_selected"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectedImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end
