//
//  RootViewController.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/9.
//  Copyright © 2020 慧. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)loadView {
    [super loadView];

    self.view.backgroundColor = bg_Color;
        
    self.navHeight = APP_NavBarHeight;
    self.tabbarHeight = APP_TabBarHeight;

    self.navBar.lineHidden = YES;
    CGRect navbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.navHeight);
    self.navBar.frame = navbarFrame;
    [self.view addSubview:self.navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = bg_Color;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navBar];
}

- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 懒加载
- (SHNavigationBar *)navBar {
    if (!_navBar) {
        _navBar = [SHNavigationBar navBarWithTitle:@"" backButton:self action:@selector(back:)];
//        UIColor *leftColor = UIColorFromRGBAlpha(0xFD444A, 1);
//        UIColor *rightColor = UIColorFromRGBAlpha(0xFC683A, 1);
//        _navBar.backgroundColor = [UIColor gradientColorImageFromColors:@[leftColor, rightColor] gradientType:(SHGradientTypeLeftToRight) imgSize:CGSizeMake(keySCREEN_WIDTH, APP_NavBarHeight)];
        _navBar.backgroundColor = Main_Color;
        _navBar.titleColor = white_Color;        
    }
    return _navBar;
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
