//
//  Header.h
//  SHBasicTools
//
//  Created by 慧 on 2022/6/6.
//  Copyright © 2022 yangsh. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define SHWeakObj(o) __weak typeof(o) weak##o = o;
#define SHStrongObj(o) __strong typeof(o) strong##o = o;

#define APPLog(format, ...) NSLog((@"%s\n" "第 %d 行\n" format), __FUNCTION__, __LINE__, ## __VA_ARGS__);

//按钮禁用
#define buttonDisabled  button.enabled = NO;\
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(APP_after_secrte * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
                        button.enabled = YES;\
                        });

//工程名称
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//屏幕尺寸
#define keySCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define keySCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//根据屏幕转化尺寸
#define CONVER_VALUE(x) ceil(keySCREEN_WIDTH * x / 375)
#define topInset(x)    ceil(keySCREEN_HEIGHT * x / 667)

#define ISIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)
//导航栏和状态栏高度
#define APP_NavBarHeight ISIPHONE_X ? 88 : 64
#define APP_TabBarHeight ISIPHONE_X ? 83 : 49
#define APP_STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height

//主题颜色
//#define Main_Color [UIColor colorWithRed:76/256.0 green:115/256.0 blue:196/256.0 alpha:1]
#define Main_Color  UIColorFromRGBAlpha(0xCB1C1C,1)
//背景色
//#define bg_Color [UIColor colorWithRed:250/256.0 green:250/256.0 blue:250/256.0 alpha:1]
#define white_Color [UIColor whiteColor]
#define black_Color [UIColor blackColor]
#define clear_Color  [UIColor clearColor]
#define bg_Color    UIColorFromRGBAlpha(0xf6f6f6,1)
#define line_Color    UIColorFromRGBAlpha(0xD8D8D8,1)
#define lightGray_Color   [UIColor lightGrayColor]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//获取本地存储的用户信息
#define KGetUserInfo(info) [[NSUserDefaults standardUserDefaults] objectForKey:info]
#define KGetUserInfoWithInteger(info) [[NSUserDefaults standardUserDefaults] integerForKey:info]

//由角度转换弧度 由弧度转换角度
#define JMDegreesToRadian(x) (M_PI * (x) / 180.0)
#define JMRadianToDegrees(radian) (radian*180.0)/(M_PI)
//获取图片资源
#define kGetImage(imageName) [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#endif /* Header_h */
