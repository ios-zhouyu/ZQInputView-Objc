//
//  ZQEmoticonsModel.h
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQEmoticonsModel : NSObject
@property (nonatomic, copy) NSString *code;//emoji编码
@property (nonatomic, copy) NSString *emoji;//emoji
@property (nonatomic, copy) NSString *chs;//发给服务器的图片表情
@property (nonatomic, copy) NSString *png;//图片表情
@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *cht;
@property (nonatomic, copy) NSString *gif;
@property (nonatomic, copy) NSString *type;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
