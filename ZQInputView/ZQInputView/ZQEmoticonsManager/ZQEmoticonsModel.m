//
//  ZQEmoticonsModel.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsModel.h"

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation ZQEmoticonsModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefinedKey = %@",key);
}

//https://www.jianshu.com/p/51deb78814e1
//自定义表情键盘-将十六进制的编码转为emoji字符
//十六进制字符串转为unicode,unicode转Character,Character转字符串
- (void)setCode:(NSString *)code {
    _code = code;
    self.emoji = [self emojiWithStringCode:code];
}

- (NSString *)emojiWithStringCode:(NSString *)stringCode{
    char *charCode = (char *)stringCode.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

- (NSString *)emojiWithIntCode:(long)intCode {
    NSString * s = [NSString stringWithFormat:@"%ld",intCode];
    int symbol = EmojiCodeToSymbol([s intValue]);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

/* swift版
 extension String{
 
 func emojiStr() -> String {
 //1.在一段字符串中查找十六进制的字符串
 let scanner = NSScanner(string: self)
 //2.将查找的字符串转换为十六进制的数字
 var value: UInt32 = 0
 scanner.scanHexInt(&value)
 //3.将十六进制的数字转化为 unicode字符
 let charCode = Character(UnicodeScalar(value))
 //4.将uniconde字符转换 字符串
 
 return "\(charCode)"
 
 }
 }
 */



@end
