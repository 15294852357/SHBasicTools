//
//  RootViewController.h
//  WisdomPeoples
//
//  Created by 慧 on 2022/5/5.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHNavigationBar;
NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController
@property (nonatomic,assign) CGFloat navHeight;
@property (nonatomic,assign) CGFloat tabbarHeight;

@property (nonatomic,strong) SHNavigationBar* navBar;

/// 自定高度
@property (nonatomic,assign) CGFloat navBgHeight;
@end

NS_ASSUME_NONNULL_END
