//
//  ZQSelectedPhotoAlbumView.m
//  ZQInputView
//
//  Created by zhouyu on 27/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQSelectedPhotoAlbumView.h"
#import "Masonry.h"
#import "ZQSelectedPhotoAlbumCell.h"

static NSString *selectedPhotoAlbumCellID = @"selectedPhotoAlbumCell";

@interface ZQSelectedPhotoAlbumView ()<UICollectionViewDelegate,UICollectionViewDataSource,ZQSelectedPhotoAlbumCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation ZQSelectedPhotoAlbumView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
    return self;
}


- (void)setSelectedPhotoAlbumArrM:(NSMutableArray *)selectedPhotoAlbumArrM {
    _selectedPhotoAlbumArrM = selectedPhotoAlbumArrM;
    [self.collectionView reloadData];
}

#pragma mark - ZQSelectedPhotoAlbumCellDelegate
- (void)deletedPhotoAlbumCellWithIndexPaht:(NSIndexPath *)indexPath {
    [self.selectedPhotoAlbumArrM removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.height,self.collectionView.bounds.size.height);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedPhotoAlbumArrM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZQSelectedPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectedPhotoAlbumCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.image = self.selectedPhotoAlbumArrM[indexPath.item];
    return cell;
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZQSelectedPhotoAlbumCell class] forCellWithReuseIdentifier:selectedPhotoAlbumCellID];
        
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(100, 100);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
    }
    return _flowLayout;
}

@end
