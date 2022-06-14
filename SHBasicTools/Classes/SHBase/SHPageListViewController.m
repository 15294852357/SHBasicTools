//
//  SHPageListViewController.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/29.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHPageListViewController.h"

@interface SHPageListViewController ()

@end

@implementation SHPageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navBar.hidden = YES;
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
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
