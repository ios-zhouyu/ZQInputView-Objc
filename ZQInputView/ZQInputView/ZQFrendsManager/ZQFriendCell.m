//
//  ZQFriendCell.m
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQFriendCell.h"
#import "Masonry.h"

@interface ZQFriendCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIView *seperatorView;
@end

@implementation ZQFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.nameLabel];
        [self addSubview:self.seperatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backView addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backView);
        make.right.mas_equalTo(self.backView).offset(-20);
        make.height.width.mas_equalTo(25);
    }];
    
    self.multipleSelectionBackgroundView = self.backView;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(20);
    }];
    
    [self.seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    self.seperatorView.backgroundColor = [UIColor blueColor];
}

- (void)setSelectedFriend:(BOOL)selectedFriend {
    _selectedFriend = selectedFriend;
    if (selectedFriend) {
        self.selectedImageView.hidden = NO;
    } else {
        self.selectedImageView.hidden = YES;
    }
}

- (void)setNameString:(NSString *)nameString {
    _nameString = nameString;
    self.nameLabel.text = nameString;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _backView;
}
- (UIView *)seperatorView {
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] init];
        _seperatorView.backgroundColor = [UIColor blueColor];
    }
    return _seperatorView;
}
- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friend_selected"]];
    }
    return _selectedImageView;
}

@end
