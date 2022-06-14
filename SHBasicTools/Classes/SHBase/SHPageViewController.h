//
//  SHPageViewController.h
//  JXAoBo
//
//  Created by 慧 on 2020/12/29.
//  Copyright © 2020 慧. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPageViewController : RootViewController<JXCategoryListContainerViewDelegate>
//@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) JXCategoryTitleView *categoryTitleView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
//标题组
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

NS_ASSUME_NONNULL_END
