//
//  UIButton.h
//  WisdomPeoples
//
//  Created by 慧 on 2019/9/25.
//  Copyright © 2019 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 titleEdgeInsets是titleLabel相对于其上下左右的inset，跟tableView的contentInset是类似的；
 如果只有title，那titleLabel的 上下左右 都是 相对于Button 的；
 如果只有image，那imageView的 上下左右 都是 相对于Button 的；
 如果同时有image和label，那image的 上下左 是 相对于Button 的，右 是 相对于label 的；
 label的 上下右 是 相对于Button的， 左 是 相对于label 的。
 */
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Exten)

@property (strong, nonatomic) UILabel *badge;
/// 角标显示的信息，可以为数字和文字
@property (nonatomic) NSString *badgeValue;
/// 角标背景颜色，默认为红色
@property (nonatomic) UIColor *badgeBGColor;
/// 角标文字的颜色
@property (nonatomic) UIColor *badgeTextColor;
/// 角标字号
@property (nonatomic) UIFont *badgeFont;
/// 角标的气泡边界
@property (nonatomic) CGFloat badgePadding;
/// 角标的最小尺寸
@property (nonatomic) CGFloat badgeMinSize;
/// 角标的x值
@property (nonatomic) CGFloat badgeOriginX;
/// 角标的y值
@property (nonatomic) CGFloat badgeOriginY;
/// 当角标为0时，自动去除角标
@property BOOL shouldHideBadgeAtZero;
/// 当角标的值发生变化，角标的动画是否显示
@property BOOL shouldAnimateBadge;

/// 自定义tag值
@property (nonatomic,strong) NSIndexPath* indexPath;

//view转化图片  使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view;
/// 文字头像
/// @param string 内容
/// @param imageSize size
/// @param imageColor 背景色
+ (UIImage *)gl_creatImageWithString:(NSAttributedString *)string imageSize:(CGSize)imageSize imageColor:(UIColor *)imageColor;
/// 修改按钮图片大小
- (UIImage*)imageWithCornerRadius:(CGFloat)radius size:(CGSize)size image:(UIImage *)image;
/// 网络图片尺寸，圆角
- (void)setSDImageWithImageString:(NSString*)imageString EdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style Radius:(CGFloat)Radius size:(CGSize)size;
/// 图片与文字位置
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
/// 设置某边边框
- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
/// 设置某个圆角
- (void)setRoundedCornersWithRectCorner:(UIRectCorner)rectCorner cornerSize:(CGSize)cornerSize;
/// 阴影
/// @param color 颜色
/// @param shadowOffset 阴影偏移,x向右，y向下，默认(0, -3),这个跟shadowRadius配合使用
/// @param shadowOpacity 阴影透明度，默认0
/// @param shadowRadius 阴影半径，默认3
- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;
/// 渐变
/// @param startPoint startPoint与endPoint分别为渐变的起始方向与结束方向，它是以矩形的四个角为基础的，（0，0）为左上角、（1，0）为右上角、（0，1）为左下角、（1，1）为右下角，默认是值是（0.5，0）和（0.5，1
/// @param endPoint 结束方向
/// @param colors 颜色属于CGColorRef类，所以必须加CGColor，而且前面还要加(id)
/// @param locations 渐变颜色的区间分布，locations的数组长度和color一致也可以不一致，这个值一般不用管它，默认是nil，会平均分布
/// @param cornerRadius 圆角
- (void)setGradientWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors locations:(NSArray*)locations cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
