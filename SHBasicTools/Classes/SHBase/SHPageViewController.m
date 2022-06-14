//
//  SHPageViewController.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/29.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHPageViewController.h"

@interface SHPageViewController ()
@end

@implementation SHPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.categoryTitleView];
    [self.categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(keySCREEN_WIDTH);
        make.top.mas_equalTo(self.navHeight);
        make.height.mas_equalTo(CONVER_VALUE(45.0f));
    }];

    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.categoryTitleView.mas_bottom).offset(CONVER_VALUE(0.5f));
    }];
}
#pragma mark JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleArray.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    SHPageListViewController* viewCon = [[SHPageListViewController alloc] init];
    return viewCon;
}

- (JXCategoryTitleView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = [[JXCategoryTitleView alloc] init];
        _categoryTitleView.backgroundColor = white_Color;
        _categoryTitleView.titleColor = UIColorFromRGBAlpha(0x8F8F8F, 1);
        _categoryTitleView.titleSelectedColor = Main_Color;
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:CONVER_VALUE(16.0f)];
        _categoryTitleView.listContainer = self.listContainerView;
    }
    return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
