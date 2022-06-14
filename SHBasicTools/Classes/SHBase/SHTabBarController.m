//
//  SHTabBarController.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHTabBarController.h"

@interface SHTabBarController ()
@property (nonatomic, strong) BusViewController *oneVC;
@property (nonatomic, strong) ParkViewController *twoVC;
@property (nonatomic, strong) MainViewController *threeVC;
@property (nonatomic, strong) CarViewController *fourVC;
@property (nonatomic, strong) MineViewController *fiveVC;
@end

@implementation SHTabBarController

- (SHTabBar*)tabBarCostom{
    if (!_tabBarCostom) {
        _tabBarCostom = [[SHTabBar alloc] init];
    }
    return _tabBarCostom;
}

#pragma mark - 类的初始化方法，只有第一次使用类的时候会调用一次该方法
+ (void)initialize{
    //tabbar去掉顶部黑线

//    if (@available(iOS 13, *)) {
//#ifdef __IPHONE_13_0
//        UITabBarAppearance *appearance = [UITabBar appearance].standardAppearance;
//        appearance.backgroundColor = bg_Color;
//        appearance.shadowColor = bg_Color;
//        [UITabBar appearance].standardAppearance = appearance;
//#endif
//    } else {
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setUnselectedItemTintColor:UIColorFromRGBAlpha(0xA5A5A5, 1)];
    [[UITabBar appearance] setTintColor:Main_Color];
//    }    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.backgroundColor = white_Color;
    [self initView];
    self.selectedIndex = 2;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [tabBar setTintColor:Main_Color];
}

- (void)initView{
    NSArray *titles = @[@"公交", @"停车", @"  ", @"车辆", @"我的"];
    NSArray *images = @[@"tabbar_bike_disabled", @"tabbar_stop_disabled", @"tabbar_main_enter", @"tabbar_car_disabled", @"tabbar_me_disabled"];
    NSArray *selectedImages = @[@"tabbar_bike_selected", @"tabbar_stop_selected", @"tabbar_main_enter", @"tabbar_car_selected", @"tabbar_me_selected"];
    BusViewController * oneVc = [[BusViewController alloc] init];
    self.oneVC = oneVc;
    ParkViewController * twoVc = [[ParkViewController alloc] init];
    self.twoVC = twoVc;
    MainViewController * threeVc = [[MainViewController alloc] init];
    self.threeVC = threeVc;
    CarViewController * fourVc = [[CarViewController alloc] init];
    self.fourVC = fourVc;
    MineViewController * fiveVc = [[MineViewController alloc] init];
    self.fiveVC = fiveVc;
    NSArray *viewControllers = @[oneVc, twoVc, threeVc, fourVc, fiveVc];
    for (int i = 0; i < viewControllers.count; i++){
        UIViewController *childVc = viewControllers[i];
        [self setVC:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SHNavigationController *nav = [[SHNavigationController alloc] initWithRootViewController:VC];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
}

+ (void)showTabBar:(UIViewController*)viewController{
    if((viewController.tabBarController == NULL) || (viewController.tabBarController.tabBar == NULL)){
        return ;
    }
    UINavigationBar * navbar = NULL;
    UITabBar *tabBar = viewController.tabBarController.tabBar;
    if( (viewController.navigationController.navigationBar != NULL) || (viewController.navigationController.navigationBar != NULL)){
        navbar = viewController.navigationController.navigationBar;
    }
    //内容显示区
    UIView *contentView;
    if ( [[viewController.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
        contentView = [viewController.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [viewController.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.backgroundColor = white_Color;
    if(tabBar.hidden == YES){
        [ contentView setFrame:CGRectMake(contentView.bounds.origin.x,contentView.bounds.origin.y,contentView.bounds.size.width, contentView.bounds.size.height + tabBar.frame.size.height)];
        [ tabBar setHidden:NO ];
        [ navbar setHidden:NO ];
    }
}

+ (void)hideTabBar:(UIViewController*)viewController{
    if((viewController.tabBarController == NULL) || (viewController.tabBarController.tabBar == NULL)){
        return ;
    }
    UINavigationBar * navbar = NULL;
    UITabBar *tabBar = viewController.tabBarController.tabBar;
    if( (viewController.navigationController.navigationBar != NULL) || (viewController.navigationController.navigationBar != NULL)){
        navbar = viewController.navigationController.navigationBar;
    }
    //内容显示区
    UIView *contentView;
    if ( [[viewController.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
        contentView = [viewController.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [viewController.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.backgroundColor = white_Color;
    if(tabBar.hidden == NO){
        [ contentView setFrame:CGRectMake(contentView.bounds.origin.x,contentView.bounds.origin.y,contentView.bounds.size.width, contentView.bounds.size.height + tabBar.frame.size.height)];
        [ tabBar setHidden:YES ];
        [ navbar setHidden:YES ];
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
