//
//  ZQFriendCell.h
//  ZQInputView
//
//  Created by zhouyu on 26/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQFriendCell : UITableViewCell
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, assign, getter=isSelectedFriend) BOOL selectedFriend;
@end
