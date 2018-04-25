//
//  ZQEmoticonsBottomView.h
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQEmoticonsBottomViewDelegate<NSObject>
@optional
- (void)emoticonsBottomViewSelectedEmoticonsTypeWithSelectedndex:(NSInteger)selectedIndex;
@end

@interface ZQEmoticonsBottomView : UIView
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id<ZQEmoticonsBottomViewDelegate> delegate;
@end
