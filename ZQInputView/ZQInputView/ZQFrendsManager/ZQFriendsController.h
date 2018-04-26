//
//  ZQFriendsController.h
//  ZQInputView
//
//  Created by zhouyu on 25/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZQFriendsController;

@protocol ZQFriendsControllerDelegate<NSObject>
- (void)friendsController:(ZQFriendsController *)friendsController selectedFriendsArr:(NSArray *)selectedFriendsArr;
@end

@interface ZQFriendsController : UITableViewController

@property (nonatomic, weak) id<ZQFriendsControllerDelegate> delegate;

@end
