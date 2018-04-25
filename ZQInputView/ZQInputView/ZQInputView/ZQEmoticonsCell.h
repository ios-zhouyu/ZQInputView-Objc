//
//  ZQEmoticonsCell.h
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQEmoticonsModel.h"

@protocol ZQEmoticonsCellDelegate <NSObject>
@optional
- (void)emoticonsCellSelectedEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model;
- (void)emoticonsCellDeletedEmoticons;
@end

@interface ZQEmoticonsCell : UICollectionViewCell
@property (nonatomic, copy) NSArray *emoticonsArr;//每页的表情

@property (nonatomic, weak) id<ZQEmoticonsCellDelegate> delegate;

@end
