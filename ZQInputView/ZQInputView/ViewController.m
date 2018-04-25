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

@interface ViewController ()<UITextViewDelegate,ZQInputAccessoryViewDelegagte,ZQEmoticonsViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) ZQEmoticonsView *emoticonsView;
@property (nonatomic, strong) ZQInputAccessoryView *accessoryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表情键盘";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.accessoryView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(self.view);
    }];
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - ZQEmoticonsViewDelegate
- (void)emoticonsViewSelectedEmoticonsWithEmoticonsModel:(ZQEmoticonsModel *)model {
    NSLog(@"%@----%@---%@",model.emoji,model.chs,model.png);
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

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - getter
-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
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
