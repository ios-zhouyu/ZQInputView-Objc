//
//  ZQPhotoAlbumController.m
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQPhotoAlbumController.h"
#import "Masonry.h"
#import "ZQPhotoAlbumCell.h"
#import "ZQPHFetchManager.h"
#import "ZQPhotoAlbumBottomView.h"
#import "ViewController.h"

static NSString *photoAlbumCellID = @"photoAlbumCell";
CGFloat margin = 5;
CGFloat col = 4;
NSInteger maxCount = 6;

@interface ZQPhotoAlbumController ()<UICollectionViewDelegate,UICollectionViewDataSource, ZQPhotoAlbumCellDelegate,ZQPhotoAlbumBottomViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, copy) NSArray *assetArr;
@property (nonatomic, strong) ZQPhotoAlbumBottomView *bottomView;
@property (nonatomic, copy) NSArray *selectedAsserArr;
@end

@implementation ZQPhotoAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"所有图片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).offset(margin);
        make.right.mas_equalTo(self.view).offset(-margin);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-margin);
    }];
    
    self.assetArr = [[ZQPHFetchManager sharedInstance] getAllPhotosFromPhotoLibrary];
    [self.collectionView reloadData];
}

#pragma amrk - ZQPhotoAlbumBottomViewDelegate
- (void)photoAlbumBottomViewCertainButtonClick {
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [self.collectionView.indexPathsForSelectedItems enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrM addObject:self.assetArr[obj.item]];
    }];
    self.selectedAsserArr = [arrM copy];
    [self cancel];
}
- (void)photoAlbumBottomViewPreviewButtonClick {
    
}

#pragma mark - UICollectionViewDelegate
- (void)photoAlbumCellSelectedImageWithIndexPath:(NSIndexPath *)indexPath flag:(BOOL)flag {
    
    if (self.collectionView.indexPathsForSelectedItems.count == maxCount - 1) {
        self.bottomView.tipLabel.hidden = NO;
    } else if (self.collectionView.indexPathsForSelectedItems.count > maxCount -1) {
        self.bottomView.tipLabel.hidden = NO;
        ZQPhotoAlbumCell *cell = (ZQPhotoAlbumCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [cell didDeselectedPhotoAlbumCell];
        return;
    } else {
        self.bottomView.tipLabel.hidden = YES;
    }
    
    if (flag) {
        [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    } else {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    
    if (self.collectionView.indexPathsForSelectedItems.count > 0) {
        self.bottomView.previewButton.selected = YES;
        self.bottomView.certainButton.selected = YES;
        [self.bottomView.certainButton setTitle:[NSString stringWithFormat:@"确认(%lu)",self.collectionView.indexPathsForSelectedItems.count] forState:UIControlStateSelected];
    } else {
        self.bottomView.previewButton.selected = NO;
        self.bottomView.certainButton.selected = NO;
        [self.bottomView.certainButton setTitle:@"确认" forState:UIControlStateSelected];
    }

    
    NSLog(@"%@",self.collectionView.indexPathsForSelectedItems);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.bounds.size.width - margin * (col + 1)) / col, (self.view.bounds.size.width - margin * (col + 1)) / col);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZQPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoAlbumCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.asset = self.assetArr[indexPath.item];
    return cell;
}


- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        ViewController *viewController = [[ViewController alloc] init];
        viewController.selectedAsserArr = self.selectedAsserArr;
    }];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.bounces = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZQPhotoAlbumCell class] forCellWithReuseIdentifier:photoAlbumCellID];
        
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(100, 100);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumLineSpacing = margin;
        _flowLayout.minimumInteritemSpacing = margin;
    }
    return _flowLayout;
}
- (ZQPhotoAlbumBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZQPhotoAlbumBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}


@end
