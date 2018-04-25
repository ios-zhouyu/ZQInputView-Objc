//
//  ZQEmoticonsManager.h
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZQEmoticonsModel;

@interface ZQEmoticonsManager : NSObject
@property (nonatomic, strong) NSMutableArray *recentEmoticonsArrM;//最近表情
@property (nonatomic, copy) NSArray *defaultEmoticonsArr;//默认表情
@property (nonatomic, copy) NSArray *emojiEmoticonsArr;//emoji表情
@property (nonatomic, copy) NSArray *lxhEmoticonsArr;//浪小花表情

//返回表情对象
- (ZQEmoticonsModel *)searchEmoticonsWithEmoticonString:(NSString *)emoticonString;

//最近使用的表情
- (void)addRecentEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model;

//获取所有表情
- (NSArray *)getAllEmoticons;

//表情分页
- (NSArray *)pageEmoticonsWithEmoticonsArr:(NSArray *)emoticonsArr;

@end
