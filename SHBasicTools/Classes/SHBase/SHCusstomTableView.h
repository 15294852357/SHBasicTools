//
//  SHCusstomTableView.h
//  JXAoBo
//
//  Created by 慧 on 2021/1/18.
//  Copyright © 2021 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface SHCusstomTableView : UITableView
/// 缺省图片
@property (nonatomic,copy) NSString* emptyImageName;
///标题
@property (nonatomic,copy) NSString* emptyTitleString;
/// 标题颜色
@property (nonatomic,copy) UIColor* emptyTitleColor;
/// 标题大小
@property (nonatomic,assign) CGFloat emptyTitleFont;

///描述
@property (nonatomic,copy) NSString* emptyDescriptionString;
/// 描述颜色
@property (nonatomic,copy) UIColor* emptyDescriptionColor;
/// 描述大小
@property (nonatomic,assign) CGFloat emptyDescriptionFont;

///按钮标题
@property (nonatomic,copy) NSString* emptyButtonTitleString;
/// 按钮标题颜色
@property (nonatomic,copy) UIColor* emptyButtonTitleColor;
/// 按钮标题大小
@property (nonatomic,assign) CGFloat emptyButtonTitleFont;

@property (nonatomic,assign) CGFloat spaceHeight;

@property (nonatomic,copy) void(^emptyReloadData)(UIScrollView* scrollView,UIButton* button);
@end

NS_ASSUME_NONNULL_END
