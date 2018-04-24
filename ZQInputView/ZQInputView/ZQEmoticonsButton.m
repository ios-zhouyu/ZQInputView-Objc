//
//  ZQEmoticonsButton.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsButton.h"

@implementation ZQEmoticonsButton

- (void)setModel:(ZQEmoticonsModel *)model {
    _model = model;
    
    if (model.path && model.png) {
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",model.path,model.png];
        [self setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
    } else {
        [self setImage:nil forState:UIControlStateNormal];
    }
    
    if (model.emoji) {
        [self setTitle:model.emoji forState:UIControlStateNormal];
    } else {
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
