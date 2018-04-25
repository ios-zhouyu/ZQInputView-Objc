//
//  ZQEmoticonsView.h
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQEmoticonsModel.h"

@protocol ZQEmoticonsViewDelegate <NSObject>
@optional
- (void)emoticonsViewSelectedEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model;
- (void)emoticonsViewDeletedEmoticons;
@end

@interface ZQEmoticonsView : UIView
@property (nonatomic, weak) id<ZQEmoticonsViewDelegate> delegate;
@end
