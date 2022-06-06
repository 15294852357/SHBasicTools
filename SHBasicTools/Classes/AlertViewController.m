//
//  AlertViewController.m
//  HaoDanBao
//
//  Created by 慧 on 2019/6/11.
//  Copyright © 2019 慧. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

+ (instancetype)initAlertControllerWithTitle:(NSString*)title massege:(NSString*)massege style:(UIAlertControllerStyle)style actionTitleArr:(NSArray *)actionTitleArr alertAction:(void (^)(UIAlertAction*) )alertAction logoImageString:(NSString*)logoImageString{
    if (![[NSString StringConverWithString:logoImageString] isEqualToString:@""]) {
        massege = [NSString stringWithFormat:@"\n \n \n%@",massege];
    }
    AlertViewController* alertCon = [AlertViewController alertControllerWithTitle:[NSString StringConverWithString:title] message:[NSString StringConverWithString:massege] preferredStyle:style];
    for (int i = 0; i < actionTitleArr.count; i ++) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:actionTitleArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertAction) {
                alertAction(action);
            }
        }];
        if (style == UIAlertControllerStyleAlert) {
            if (i == actionTitleArr.count - 1) {
                [action setValue:Main_Color forKey:@"_titleTextColor"];
            }else{
                [action setValue:UIColorFromRGBAlpha(0x999999, 1) forKey:@"_titleTextColor"];
            }
        }else{
            if (i == actionTitleArr.count - 1) {
                [action setValue:Main_Color forKey:@"_titleTextColor"];
            }else{
                [action setValue:UIColorFromRGBAlpha(0x333333,1) forKey:@"_titleTextColor"];
            }
        }
        [alertCon addAction:action];
    }
    
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake((CONVER_VALUE(270) - CONVER_VALUE(50.0f)) / 2, CONVER_VALUE(10.0f), CONVER_VALUE(50.0f), CONVER_VALUE(50.0f));
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = kGetImage(logoImageString);
    [alertCon.view addSubview:imageView];

    return alertCon;
}

-(void)showAlertController{
    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}

-(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
