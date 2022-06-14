//
//  SHTabBarController.h
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHTabBarController : UITabBarController
@property (nonatomic,strong) SHTabBar *tabBarCostom;

+ (void)hideTabBar:(UIViewController*)viewController;
+ (void)showTabBar:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
