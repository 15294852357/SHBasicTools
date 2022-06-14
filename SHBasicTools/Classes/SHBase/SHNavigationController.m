//
//  SHNavigationController.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHNavigationController.h"

@interface SHNavigationController ()<UINavigationBarDelegate>

@end

@implementation SHNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        self.interactivePopGestureRecognizer.delegate = nil;

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (UIViewController*)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}
#pragma mark --------navigation delegate
//该方法可以解决popRootViewController时tabbar的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews){
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBar removeFromSuperview];
        }
    }
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
