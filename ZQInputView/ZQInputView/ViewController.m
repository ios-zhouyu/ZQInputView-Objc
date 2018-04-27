//
//  ViewController.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ViewController.h"
#import "ZQEmoticonsView.h"
#import "Masonry.h"
#import "ZQInputAccessoryView.h"
#import "ZQTextAttachment.h"
#import "ZQFriendsController.h"
#import "ZQHighlightTextStorage.h"
#import "ZQPhtotAlbumNavController.h"
#import "ZQPHFetchManager.h"
#import "ZQPhotoAlbumController.h"
#import "ZQSelectedPhotoAlbumView.h"

@interface ViewController ()<UITextViewDelegate,ZQInputAccessoryViewDelegagte,ZQEmoticonsViewDelegate,ZQFriendsControllerDelegate,ZQPhotoAlbumControllerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) ZQEmoticonsView *emoticonsView;
@property (nonatomic, strong) ZQInputAccessoryView *accessoryView;
@property (nonatomic, strong) ZQHighlightTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;

@property (nonatomic, strong) NSArray *selectedPhotoAlbumArr;
@property (nonatomic, strong) ZQSelectedPhotoAlbumView *selectedPhotoAlbumView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表情键盘";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishState)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setTextKit];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.accessoryView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(self.view);
    }];
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [[ZQPHFetchManager sharedInstance] checkFirstUsePhotoKit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    NSLog(@"%@",self.selectedAsserArr);
}

- (void)setTextKit {
    self.textStorage = [[ZQHighlightTextStorage alloc] init];
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.textContainer = [[NSTextContainer alloc] init];
    
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
    
}

#pragma mark - ZQPhotoAlbumControllerDelegate
- (void)photoAlbumControllerSelectedPhotoAlbumArr:(NSArray *)selectedAssetArr {
    self.selectedPhotoAlbumArr = [[ZQPHFetchManager sharedInstance] getSelectedPhotosImageWithSelectedAssetArr:selectedAssetArr];
    [self.view addSubview:self.selectedPhotoAlbumView];
    [self.selectedPhotoAlbumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.accessoryView.mas_top);
        make.height.mas_equalTo(100);
    }];
    self.selectedPhotoAlbumView.selectedPhotoAlbumArr = self.selectedPhotoAlbumArr;
}

#pragma mark - ZQFriendsControllerDelegate
- (void)friendsController:(ZQFriendsController *)friendsController selectedFriendsArr:(NSArray *)selectedFriendsArr {
    for (int i = 0; i < selectedFriendsArr.count; i++) {
        [self.textView replaceRange:self.textView.selectedTextRange withText:selectedFriendsArr[i]];
    }
    [self.textStorage replaceCharactersInRange:NSMakeRange(0, self.textView.text.length) withString:self.textView.text];
}

#pragma mark - publish state
- (void)publishState {
    __block NSString *publishString = @"";
    [self.textView.attributedText enumerateAttributesInRange:NSMakeRange(0, self.textView.attributedText.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (attrs[@"NSAttachment"]) {//图片替换成对应的文字
            ZQTextAttachment *textAttachment = attrs[@"NSAttachment"];
            if (textAttachment.model.chs) {
                publishString = [publishString stringByAppendingString:textAttachment.model.chs];
            }
        } else {//文字或者表情
            NSString *subString = [self.textView.text substringWithRange:range];
            publishString = [publishString stringByAppendingString:subString];
        }
    }];
    NSLog(@"%@",publishString);
}

#pragma mark - ZQEmoticonsViewDelegate
- (void)emoticonsViewDeletedEmoticons {
    if (self.textView.attributedText) {
        //当前光标的位置
        NSRange currentRange = self.textView.selectedRange;
        NSAttributedString *beforeAttributedString = [self.textView.attributedText attributedSubstringFromRange:NSMakeRange(0, currentRange.location)];
        NSAttributedString *afterAttributedString = [self.textView.attributedText attributedSubstringFromRange:NSMakeRange(currentRange.location , self.textView.attributedText.length - beforeAttributedString.length)];
        
        //如果前半部分没有内容,就不处理了
        if (beforeAttributedString.length <= 0) {
            return;
        }
        //光标前部分的beforeAttributedString减少一个(emoji字符占两个字节)//判断即将被删除的是一个字和图片,还是emoji
        NSRange lastRange = [beforeAttributedString.string rangeOfComposedCharacterSequenceAtIndex:beforeAttributedString.string.length -1];
        beforeAttributedString = [beforeAttributedString attributedSubstringFromRange:NSMakeRange(0, beforeAttributedString.length - lastRange.length)];
        
        //前后两部分合并赋值给textView
        NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:beforeAttributedString];
        [resultAttributedString appendAttributedString:afterAttributedString];
        self.textView.attributedText = resultAttributedString;
        
        //光标前移
        self.textView.selectedRange = NSMakeRange(currentRange.location - lastRange.length,0);
    }
    
}
- (void)emoticonsViewSelectedEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model {
    if (model.emoji) {//表情
        [self.textView replaceRange:self.textView.selectedTextRange withText:model.emoji];
    } else if (model.png && model.path) {//图片
        //保存先前的attributedText内容
       NSMutableAttributedString *oldAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        
        //创建包含TextAttachment附件的attributedString
        ZQTextAttachment *textAttachment = [[ZQTextAttachment alloc] init];
        textAttachment.model = model;
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",model.path,model.png];
        textAttachment.image = [UIImage imageWithContentsOfFile:imagePath];
        CGFloat fontHeight = self.textView.font.lineHeight;
        textAttachment.bounds = CGRectMake(0, -4, fontHeight, fontHeight);
        NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        //获取光标的位置,在当前光标出插入图片
        NSRange currentRange = self.textView.selectedRange;
        
        //合并包含TextAttachment附件的attributedString,赋值给textView
        [oldAttributedString replaceCharactersInRange:NSMakeRange(currentRange.location, 0) withAttributedString:attachmentAttributedString];
        [oldAttributedString addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, oldAttributedString.length)];
        self.textView.attributedText = oldAttributedString;
        
        //光标下移
        self.textView.selectedRange = NSMakeRange(currentRange.location + 1,0);
    }
}

#pragma mark - ZQInputAccessoryViewDelegagte
- (void)inputAccessoryViewButtonClickWithStatus:(ZQInputAccessoryViewButtonStatus)status {
    if (status == ZQInputAccessoryViewButtonStatusDone) {
        [self.view endEditing:YES];
    } else if (status == ZQInputAccessoryViewButtonStatusEmoticons) {
        self.textView.inputView = self.emoticonsView;
        [self.textView becomeFirstResponder];
        [self.textView reloadInputViews];
    } else if (status == ZQInputAccessoryViewButtonStatusCheckInputView) {
        self.textView.inputView = nil;
        [self.textView reloadInputViews];
    } else if (status == ZQInputAccessoryViewButtonStatusFriend) {
        ZQFriendsController *friendsController = [[ZQFriendsController alloc] init];
        friendsController.delegate = self;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:friendsController] animated:YES completion:nil];
    } else if (status == ZQInputAccessoryViewButtonStatusPhoto) {
        ZQPhotoAlbumController *photoAlbumController = [[ZQPhotoAlbumController alloc] init];
        photoAlbumController.delegate = self;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:photoAlbumController] animated:YES completion:nil];
    } else if (status == ZQInputAccessoryViewButtonStatusCamera) {
        
    }
}

#pragma mark - UIKeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification{
    CGFloat keyboardHeight = [self getKeyboardHeightWithNotification:notification];
    [self.accessoryView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-keyboardHeight);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [self.accessoryView keyboardHidden];
    [self.accessoryView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.textView.inputView = nil;
        [self.view endEditing:YES];
    }];
}

- (CGFloat)getKeyboardHeightWithNotification:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    return keyboardRect.size.height;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - getter
- (ZQSelectedPhotoAlbumView *)selectedPhotoAlbumView {
    if (!_selectedPhotoAlbumView) {
        _selectedPhotoAlbumView = [[ZQSelectedPhotoAlbumView alloc] init];
        _selectedPhotoAlbumView.backgroundColor = [UIColor clearColor];
    }
    return _selectedPhotoAlbumView;
}
-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.frame textContainer:self.textContainer];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16.0];
        [_textView becomeFirstResponder];
    }
    return _textView;
}
- (ZQEmoticonsView *)emoticonsView {
    if (!_emoticonsView) {
        _emoticonsView = [[ZQEmoticonsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
        _emoticonsView.delegate = self;
    }
    return _emoticonsView;
}
- (ZQInputAccessoryView *)accessoryView {
    if (!_accessoryView) {
        _accessoryView = [[ZQInputAccessoryView alloc] init];
        _accessoryView.delegate = self;
    }
    return _accessoryView;
}

@end
