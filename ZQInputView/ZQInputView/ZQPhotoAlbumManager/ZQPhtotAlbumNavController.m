//
//  ZQPhtotAlbumNavController.m
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQPhtotAlbumNavController.h"
#import "ZQPhotoAlbumController.h"

@interface ZQPhtotAlbumNavController ()

@end

@implementation ZQPhtotAlbumNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self pushViewController:[[ZQPhotoAlbumController alloc] init] animated:YES];
}

@end
