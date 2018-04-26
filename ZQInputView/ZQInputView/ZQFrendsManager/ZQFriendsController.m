//
//  ZQFriendsController.m
//  ZQInputView
//
//  Created by zhouyu on 25/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQFriendsController.h"
#import "ZQFriendCell.h"

@interface ZQFriendsController ()
@property (nonatomic, copy) NSArray *friendArr;
@property (nonatomic, strong) NSMutableArray *selectedFrendsArrM;
@end

@implementation ZQFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的好友";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(certain)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[ZQFriendCell class] forCellReuseIdentifier:@"friendCell"];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - event
- (void)certain {
    __weak typeof(self) weakSelf = self;
    [self.tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.selectedFrendsArrM addObject:[NSString stringWithFormat:@"@%@ ",weakSelf.friendArr[obj.row]]];
    }];
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(friendsController:selectedFriendsArr:)]) {
            [weakSelf.delegate friendsController:self selectedFriendsArr:weakSelf.selectedFrendsArrM];
        }
    }];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZQFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    cell.nameString = self.friendArr[indexPath.row];
    return cell;
}


#pragma mark - getter
- (NSArray *)friendArr {
    if (!_friendArr) {
        _friendArr = @[@"阿正",@"宝海双",@"曹林林",@"冬梅",@"elisi",@"芳芳",@"高林",@"和珅",@"image",@"芒果",@"聂盒",@"欧阳修",@"陪陪",@"曲艺",@"如意真经",@"孙红雷",@"塔塔123",@"uuumei",@"vwedie",@"王海波",@"迅雷",@"于晓萌",@"郑爽"];
    }
    return _friendArr;
}
- (NSMutableArray *)selectedFrendsArrM {
    if (!_selectedFrendsArrM) {
        _selectedFrendsArrM = [[NSMutableArray alloc] init];
    }
    return _selectedFrendsArrM;
}

@end
