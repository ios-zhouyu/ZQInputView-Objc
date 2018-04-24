
//
//  ZQEmoticonsManager.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsManager.h"
#import "ZQEmoticonsModel.h"

#define pageButtonCount 20

@interface ZQEmoticonsManager ()

@end

@implementation ZQEmoticonsManager

- (ZQEmoticonsModel *)searchEmoticonsWithEmoticonString:(NSString *)emoticonString {
    //默认表情
    for (ZQEmoticonsModel *model in self.defaultEmoticonsArr) {
        if ([emoticonString isEqualToString:model.chs]) {
            return model;
        }
    }
    //浪小花
    for (ZQEmoticonsModel *model in self.lxhEmoticonsArr) {
        if ([emoticonString isEqualToString:model.chs]) {
            return model;
        }
    }
    return nil;
}

- (void)addRecentEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model {
    if (![self.recentEmoticonsArrM containsObject:model]) {
        [self.recentEmoticonsArrM insertObject:model atIndex:0];
        if (self.recentEmoticonsArrM.count > pageButtonCount) {//// 最近表情就不要分组,多余pageButtonCount个就得删除
            [self.recentEmoticonsArrM removeLastObject];
        }
    }
}

- (NSArray *)getAllEmoticons {//[self pageEmoticonsWithEmoticonsArr:self.recentEmoticonsArrM],
    return @[[self pageEmoticonsWithEmoticonsArr:self.defaultEmoticonsArr],[self pageEmoticonsWithEmoticonsArr:self.emojiEmoticonsArr],[self pageEmoticonsWithEmoticonsArr:self.lxhEmoticonsArr]];
}

- (NSArray *)pageEmoticonsWithEmoticonsArr:(NSArray *)emoticonsArr {
    NSInteger page = (emoticonsArr.count - 1) / pageButtonCount + 1;
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (int i = 0; i < page; i++) {
        NSInteger length = pageButtonCount;
        NSInteger location = i * length;
        if (length + location > emoticonsArr.count) {
            length = emoticonsArr.count - location;
        }
        NSArray *subArr = [emoticonsArr subarrayWithRange:NSMakeRange(location, length)];
        [arrM addObject:subArr];
    }
    return [arrM copy];
}

 // 1. 先拿到Emoticons.Bundle
 // 2. 根据包名,来获取info.plist
 // 3. 获取info.plist 里的 emoticons数组
 // 4. 对数组进行遍历,来转换成模型
- (NSArray *)getEmoticonsWithTypeString:(NSString *)typeString {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
    NSString *packagePath = [path stringByAppendingPathComponent:typeString];
    NSString *infoPath = [packagePath stringByAppendingPathComponent:@"info.plist"];
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:infoPath];
    NSArray *emoticonsArr = infoDict[@"emoticons"];
    NSMutableArray *arrM = [[NSMutableArray alloc] initWithCapacity:emoticonsArr.count];
    for (NSDictionary *dict in emoticonsArr) {
        ZQEmoticonsModel *model = [ZQEmoticonsModel modelWithDict:dict];
        model.path = packagePath;
        [arrM addObject:model];
    }
    return [arrM copy];
}

#pragma mark - getter
- (NSMutableArray *)recentEmoticonsArrM {
    if (!_recentEmoticonsArrM) {
        _recentEmoticonsArrM = [[NSMutableArray alloc] init];
    }
    return _recentEmoticonsArrM;
}
- (NSArray *)defaultEmoticonsArr {
    if (!_defaultEmoticonsArr) {
        _defaultEmoticonsArr = [self getEmoticonsWithTypeString:@"com.sina.default"];
    }
    return _defaultEmoticonsArr;
}
- (NSArray *)emojiEmoticonsArr {
    if (!_emojiEmoticonsArr) {
        _emojiEmoticonsArr = [self getEmoticonsWithTypeString:@"com.apple.emoji"];
    }
    return _emojiEmoticonsArr;
}
- (NSArray *)lxhEmoticonsArr {
    if (!_lxhEmoticonsArr) {
        _lxhEmoticonsArr = [self getEmoticonsWithTypeString:@"com.sina.lxh"];
    }
    return _lxhEmoticonsArr;
}

@end
