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

@interface ViewController ()
@property (nonatomic, strong) ZQEmoticonsView *emoticonsView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表情键盘";
    
    [self.view addSubview:self.emoticonsView];
    [self.emoticonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
}



- (ZQEmoticonsView *)emoticonsView {
    if (!_emoticonsView) {
        _emoticonsView = [[ZQEmoticonsView alloc] init];
    }
    return _emoticonsView;
}


@end
