//
//  RootViewController.h
//  JXAoBo
//
//  Created by 慧 on 2020/12/9.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController
@property (nonatomic,assign) CGFloat navHeight;
@property (nonatomic,assign) CGFloat tabbarHeight;

@property (nonatomic,strong) SHNavigationBar* navBar;
@end

NS_ASSUME_NONNULL_END
