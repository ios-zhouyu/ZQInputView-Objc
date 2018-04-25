//
//  ZQEmoticonsBottomView.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsBottomView.h"
#import "Masonry.h"

@interface ZQEmoticonsBottomView ()
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *buttonArrM;
@end

@implementation ZQEmoticonsBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = CGRectGetWidth(self.bounds) / self.titleArr.count;
    CGFloat buttonHeight = CGRectGetHeight(self.bounds);
    
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 1, buttonWidth, buttonHeight)];
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_selected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
        }
        [self addSubview:button];
        [self.buttonArrM addObject:button];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = (currentIndex == obj.tag) ? YES : NO;
    }];
}

- (void)buttonClick:(UIButton *)render {
    [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = (render.tag == obj.tag) ? YES : NO;
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(emoticonsBottomViewSelectedEmoticonsTypeWithSelectedndex:)]) {
        [self.delegate emoticonsBottomViewSelectedEmoticonsTypeWithSelectedndex:render.tag];
    }
}


#pragma mark - getter
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"默认",@"emoji",@"浪小花"];
    }
    return _titleArr;
}
- (NSMutableArray *)buttonArrM {
    if (!_buttonArrM) {
        _buttonArrM = [[NSMutableArray alloc] init];
    }
    return _buttonArrM;
}

@end
