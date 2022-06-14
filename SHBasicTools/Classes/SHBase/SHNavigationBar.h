//
//  SHNavigationBar.h
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNavigationBar : UIView {
    UILabel *labTitle; //显示title属性，如果设置了titleView，则隐藏此标签
    UIView *container; //用于显示titleView
    UIView *lineView;
}
@property (nonatomic, assign) BOOL isRootViewCon;

@property (nonatomic, strong) UIImageView *navBgView;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UILabel *labTitle;

/* 显示自定义的中间视图
 * 自定义的视图将添加到_container中,并居中显示
 */
@property (nonatomic, strong) UIView *titleView; //显示自定义的view

/* 显示自定义的左边视图
 * 请指定自定义的视图的frame，BLNavigationBar将改变其位置，但不会改变大小
 */
@property (nonatomic, strong) UIView *leftView;

/* 显示自定义的右边视图
 * 请指定自定义的视图的frame，BLNavigationBar将改变其位置，但不会改变大小
 */
@property (nonatomic, strong) UIView *righView;

/** 隐藏navbar的分割线 */
@property (nonatomic, assign) BOOL lineHidden;

@property (nonatomic, assign) CGFloat titleLabelLeft; //调整titleLabel的位置
@property (nonatomic, assign) CGFloat titleViewOffset; //调整titleView的位置

+ (UIButton *)backButtonTarget:(id)target action:(SEL)sel backImageString:(NSString*)backImageString;

//常用带返回按钮的导航栏,
+ (SHNavigationBar *)navBarWithTitle:(NSString *)title backButton:(id)target action:(SEL)sel;

+ (instancetype)sharedInit;
@end
