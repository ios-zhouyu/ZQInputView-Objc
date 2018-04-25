//
//  ZQInputAccessoryView.h
//  ZQInputView
//
//  Created by zhouyu on 25/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZQInputAccessoryViewButtonStatus) {
    ZQInputAccessoryViewButtonStatusPhoto,
    ZQInputAccessoryViewButtonStatusCamera,
    ZQInputAccessoryViewButtonStatusFriend,
    ZQInputAccessoryViewButtonStatusEmoticons,
    ZQInputAccessoryViewButtonStatusDone,
    ZQInputAccessoryViewButtonStatusCheckInputView
};

@protocol ZQInputAccessoryViewDelegagte <NSObject>
@optional
- (void)inputAccessoryViewButtonClickWithStatus:(ZQInputAccessoryViewButtonStatus)status;
@end

@interface ZQInputAccessoryView : UIView
@property (nonatomic, weak) id<ZQInputAccessoryViewDelegagte> delegate;

- (void)keyboardHidden;
@end
