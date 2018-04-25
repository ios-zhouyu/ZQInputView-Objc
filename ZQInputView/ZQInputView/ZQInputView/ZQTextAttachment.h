//
//  ZQTextAttachment.h
//  ZQInputView
//
//  Created by zhouyu on 25/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQEmoticonsModel.h"

@interface ZQTextAttachment : NSTextAttachment
@property (nonatomic, strong) ZQEmoticonsModel *model;
@end
