//
//  ZQEmoticonsView.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsView.h"
#import "ZQEmoticonsCell.h"
#import "Masonry.h"
#import "ZQEmoticonsManager.h"
#import "ZQEmoticonsBottomView.h"

static NSString *emoticonCellID = @"emoticonCell";

@interface ZQEmoticonsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,ZQEmoticonsBottomViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) ZQEmoticonsBottomView *bottomView;
@end

@implementation ZQEmoticonsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        [self addSubview:self.bottomView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

#pragma mark - ZQEmoticonsBottomViewDelegate
- (void)emoticonsBottomViewSelectedEmoticonsTypeWithSelectedndex:(NSInteger)selectedIndex {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:selectedIndex] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *currentIndexPath = self.collectionView.indexPathsForVisibleItems.firstObject;
    self.bottomView.currentIndex = currentIndexPath.section;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[[[ZQEmoticonsManager alloc] init] getAllEmoticons] count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[[[ZQEmoticonsManager alloc] init] getAllEmoticons] objectAtIndex:section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZQEmoticonsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emoticonCellID forIndexPath:indexPath];
    // [[[ZQEmoticonsManager alloc] init] getAllEmoticons] -- 4个表情包
    // [[[[ZQEmoticonsManager alloc] init] getAllEmoticons] objectAtIndex:indexPath.section] -- 一个表情包
    // [[[[[ZQEmoticonsManager alloc] init] getAllEmoticons] objectAtIndex:indexPath.section] objectAtIndex:indexPath.item] -- 对应着20个表情,所切割的一页
    cell.emoticonsArr = [[[[[ZQEmoticonsManager alloc] init] getAllEmoticons] objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZQEmoticonsCell class] forCellWithReuseIdentifier:emoticonCellID];
        
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(100, 100);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}
- (ZQEmoticonsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZQEmoticonsBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

@end
