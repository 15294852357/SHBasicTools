//
//  SHTabBar.h
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTabBar : UITabBar
@property (nonatomic, strong) UIButton *middleBtn;

+ (instancetype)sharedInit;
@end

NS_ASSUME_NONNULL_END
