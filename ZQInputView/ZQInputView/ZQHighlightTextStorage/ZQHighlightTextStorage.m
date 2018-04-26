//
//  ZQHighlightTextStorage.m
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQHighlightTextStorage.h"

@interface ZQHighlightTextStorage ()
@property (nonatomic, strong) NSMutableAttributedString *mutableAttributedString;
@property (nonatomic, strong) NSRegularExpression *regularExpression;
@end

@implementation ZQHighlightTextStorage

- (instancetype)init {
    if (self = [super init]) {
        self.mutableAttributedString = [[NSMutableAttributedString alloc] init];
        self.regularExpression = [NSRegularExpression regularExpressionWithPattern:@"@\\w+" options:0 error:NULL];
    }
    return self;
}

- (NSString *)string {
    return self.mutableAttributedString.string;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.mutableAttributedString attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.mutableAttributedString replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
    [self endEditing];
}

-(void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.mutableAttributedString setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:0];
    [self endEditing];
}

- (void)processEditing {
    [super processEditing];
    NSRange paragaphRange = [self.string paragraphRangeForRange:self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    [self.regularExpression enumerateMatchesInString:self.string options:NSMatchingReportProgress range:paragaphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:result.range];
    }];
}

@end
