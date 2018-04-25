//
//  ZQEmoticonsCell.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsCell.h"
#import "ZQEmoticonsModel.h"
#import "Masonry.h"
#import "ZQEmoticonsButton.h"

#define pageButtonCount 44
#define colCount 9
#define rowCount 5

@interface ZQEmoticonsCell ()
@property (nonatomic, strong) NSMutableArray *emoticonsButtonArrM;//表情按钮
@property (nonatomic, strong) UIButton *deleteButton;//删除按钮
@end

@implementation ZQEmoticonsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat buttonWidth = self.bounds.size.width / colCount;
        CGFloat buttonHeight = self.bounds.size.height / rowCount;
        
        //pageButtonCount个表情按钮
        for (int i = 0; i < pageButtonCount; i++) {
            ZQEmoticonsButton *emoticonsButton = [ZQEmoticonsButton buttonWithType:UIButtonTypeCustom];
            [emoticonsButton addTarget:self action:@selector(emoticonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            emoticonsButton.titleLabel.font = [UIFont systemFontOfSize:32];
            NSInteger col = i % colCount;
            NSInteger row = i / colCount;
            CGFloat buttonX = buttonWidth * col;
            CGFloat buttonY = buttonHeight * row;
            emoticonsButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
            [self addSubview:emoticonsButton];
            [self.emoticonsButtonArrM addObject:emoticonsButton];
            
            //1个删除按钮
            self.deleteButton.frame = CGRectMake(buttonWidth * (colCount - 1), buttonHeight * (rowCount - 1), buttonWidth, buttonHeight);
            [self addSubview:self.deleteButton];
        }
    }
    return self;
}

#pragma mark - button click
- (void)emoticonButtonClick:(ZQEmoticonsButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(emoticonsCellSelectedEmoticonsWithEmoticonsModel:)]) {
        [self.delegate emoticonsCellSelectedEmoticonsWithEmoticonsModel:button.model];
    }
}
- (void)deleteButtonClick:(UIButton *)button {
    
}

#pragma mark - setter
- (void)setEmoticonsArr:(NSArray *)emoticonsArr {
    _emoticonsArr = emoticonsArr;
    for (ZQEmoticonsButton *button in self.emoticonsButtonArrM) {
        button.hidden = YES;
    }
    [emoticonsArr enumerateObjectsUsingBlock:^(ZQEmoticonsModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        ZQEmoticonsButton *button = self.emoticonsButtonArrM[idx];
        button.model = model;
        button.hidden = NO;
    }];
}

#pragma mark - getter
- (NSMutableArray *)emoticonsButtonArrM {
    if (!_emoticonsButtonArrM) {
        _emoticonsButtonArrM = [[NSMutableArray alloc] init];
    }
    return _emoticonsButtonArrM;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_normal"] forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
