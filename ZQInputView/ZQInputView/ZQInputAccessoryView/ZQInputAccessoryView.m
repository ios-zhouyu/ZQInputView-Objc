//
//  ZQInputAccessoryView.m
//  ZQInputView
//
//  Created by zhouyu on 25/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQInputAccessoryView.h"
#import "Masonry.h"

@interface ZQInputAccessoryView ()
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *friendButton;
@property (nonatomic, strong) UIButton *emoticonsButton;
@property (nonatomic, strong) UIButton *doneButton;
@end

@implementation ZQInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
        
        [self addSubview:self.photoButton];
        [self addSubview:self.cameraButton];
        [self addSubview:self.friendButton];
        [self addSubview:self.emoticonsButton];
        [self addSubview:self.doneButton];
        
        [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.photoButton.mas_right).offset(10);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.cameraButton.mas_right).offset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        [self.emoticonsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.friendButton.mas_right).offset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-10);
            make.width.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

- (void)keyboardHidden {
    self.emoticonsButton.selected = NO;
}

#pragma mark - event
- (void)photoButtonClick:(UIButton *)render{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewButtonClickWithStatus:)]) {
        [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusPhoto];
    }
}
- (void)cameraButtonClick:(UIButton *)render{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewButtonClickWithStatus:)]) {
        [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusCamera];
    }
}
- (void)friendButtonClick:(UIButton *)render{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewButtonClickWithStatus:)]) {
        [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusFriend];
    }
}
- (void)emoticonsButtonClick:(UIButton *)render{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewButtonClickWithStatus:)]) {
        render.selected = !render.selected;
        if (render.selected) {
            [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusEmoticons];
        } else {
            [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusCheckInputView];
        }
    }
}
- (void)doneButtonClick:(UIButton *)render{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewButtonClickWithStatus:)]) {
        [self.delegate inputAccessoryViewButtonClickWithStatus:ZQInputAccessoryViewButtonStatusDone];
    }
}

#pragma mark - getter
- (UIButton *)photoButton {
    if (!_photoButton) {
        _photoButton = [[UIButton alloc] init];
        [_photoButton setImage:[UIImage imageNamed:@"compose_photo_normal"] forState:UIControlStateNormal];
        [_photoButton setImage:[UIImage imageNamed:@"compose_photo_highlighted"] forState:UIControlStateHighlighted];
        [_photoButton addTarget:self action:@selector(photoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoButton;
}
- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [[UIButton alloc] init];
        [_cameraButton setImage:[UIImage imageNamed:@"compose_camera_normal"] forState:UIControlStateNormal];
        [_cameraButton setImage:[UIImage imageNamed:@"compose_camera_highlighted"] forState:UIControlStateHighlighted];
        [_cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}
- (UIButton *)friendButton {
    if (!_friendButton) {
        _friendButton = [[UIButton alloc] init];
        [_friendButton setImage:[UIImage imageNamed:@"compose_friend_normal"] forState:UIControlStateNormal];
        [_friendButton setImage:[UIImage imageNamed:@"compose_friend_highlighted"] forState:UIControlStateHighlighted];
        [_friendButton addTarget:self action:@selector(friendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendButton;
}
- (UIButton *)emoticonsButton {
    if (!_emoticonsButton) {
        _emoticonsButton = [[UIButton alloc] init];
        [_emoticonsButton setImage:[UIImage imageNamed:@"compose_emoticons_normal"] forState:UIControlStateNormal];
        [_emoticonsButton setImage:[UIImage imageNamed:@"compose_emoticons_highlighted"] forState:UIControlStateHighlighted];
        [_emoticonsButton setImage:[UIImage imageNamed:@"compose_emoticons_highlighted"] forState:UIControlStateSelected];
        [_emoticonsButton addTarget:self action:@selector(emoticonsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _emoticonsButton.selected = NO;
    }
    return _emoticonsButton;
}
- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] init];
        [_doneButton setImage:[UIImage imageNamed:@"compose_done_normal"] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

@end
