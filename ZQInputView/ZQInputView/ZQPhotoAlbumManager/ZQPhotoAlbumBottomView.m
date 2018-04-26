//
//  ZQAllImageBottomView.m
//  ZQCameraManager
//
//  Created by zhouyu on 21/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQPhotoAlbumBottomView.h"
#import "Masonry.h"

@interface ZQPhotoAlbumBottomView()
@property (nonatomic, strong) UIView *topSeperatorView;//分割线

@end

@implementation ZQPhotoAlbumBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.topSeperatorView];
        [self addSubview:self.previewButton];
        [self addSubview:self.certainButton];
        [self addSubview:self.tipLabel];
        
        [self.topSeperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(60);
        }];
        
        [self.certainButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(60);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.certainButton.mas_left).offset(-10);
        }];
        
    }
    return self;
}

- (void)previewSelectedImagsArr:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoAlbumBottomViewPreviewButtonClick)]) {
        [self.delegate photoAlbumBottomViewPreviewButtonClick];
    }
}

- (void)certainWithSelectedImagsArr:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoAlbumBottomViewCertainButtonClick)]) {
        [self.delegate photoAlbumBottomViewCertainButtonClick];
    }
}



#pragma mark - getter
- (UIView *)topSeperatorView {
    if (!_topSeperatorView) {
        _topSeperatorView = [[UIView alloc] init];
        _topSeperatorView.backgroundColor = [UIColor grayColor];
    }
    return _topSeperatorView;
}
- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton = [[UIButton alloc] init];
        [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _previewButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_previewButton addTarget:self action:@selector(previewSelectedImagsArr:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewButton;
}
- (UIButton *)certainButton {
    if (!_certainButton) {
        _certainButton = [[UIButton alloc] init];
        [_certainButton setTitle:@"确定" forState:UIControlStateNormal];
        [_certainButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_certainButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _certainButton.backgroundColor = [UIColor lightGrayColor];
        _certainButton.layer.cornerRadius = 2.0;
        _certainButton.layer.masksToBounds = YES;
        _certainButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_certainButton addTarget:self action:@selector(certainWithSelectedImagsArr:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certainButton;
}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"最多添加6张图片";
        _tipLabel.font = [UIFont systemFontOfSize:12.0];
        _tipLabel.textAlignment = NSTextAlignmentRight;
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

@end
