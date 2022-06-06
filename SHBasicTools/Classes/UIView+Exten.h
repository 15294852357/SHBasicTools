//
//  UIView+Exten.h
//  WisdomPeoples
//
//  Created by 慧 on 2022/5/5.
//  Copyright © 2020 慧. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum :NSInteger{
    SHShadowPathLeft,
    SHShadowPathRight,
    SHShadowPathTop,
    SHShadowPathBottom,
    SHShadowPathNoTop,
    SHShadowPathAllSide
} SHShadowPathSide;

@interface UIView (Exten)

/**
 * Shortcut for frame.origin.x
 */
@property(nonatomic, assign)CGFloat x;
/**
 * Shortcut for frame.origin.y
 */
@property(nonatomic, assign)CGFloat y;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic, assign) CGSize size;

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic, assign) CGFloat left;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic, assign) CGFloat right;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic, assign) CGFloat top;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic, assign) CGFloat bottom;


/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic, assign) CGFloat centerX;


/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic, assign) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic, assign) CGFloat height;


// bounds accessors
@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;


// content getters
@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;


// additional frame setters
- (void)setLeft:(CGFloat)left right:(CGFloat)right;
- (void)setWidth:(CGFloat)width right:(CGFloat)right;
- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom;

/// 设置cell圆角（tableview四个角）
/// @param radius 角度
+ (void)setTabelViewCellWithRadius:(CGFloat)radius cell:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath tableView:(UITableView *)tableView;

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

/// 阴影
/// @param shadowColor 阴影颜色
/// @param shadowOpacity 阴影透明度，默认0
/// @param shadowRadius 阴影半径，默认3
/// @param shadowPathSide 设置那一侧的阴影
/// @param shadowPathWidth 阴影宽度
-(void)setShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(SHShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

/// 阴影
/// @param color 颜色
/// @param shadowOffset 阴影偏移,x向右，y向下，默认(0, -3),这个跟shadowRadius配合使用
/// @param shadowOpacity 阴影透明度，默认0
/// @param shadowRadius 阴影半径，默认3
//- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;


/// 渐变
/// @param startPoint startPoint与endPoint分别为渐变的起始方向与结束方向，它是以矩形的四个角为基础的，（0，0）为左上角、（1，0）为右上角、（0，1）为左下角、（1，1）为右下角，默认是值是（0.5，0）和（0.5，1
/// @param endPoint 结束方向
/// @param colors 颜色属于CGColorRef类，所以必须加CGColor，而且前面还要加(id)
/// @param locations 渐变颜色的区间分布，locations的数组长度和color一致也可以不一致，这个值一般不用管它，默认是nil，会平均分布
/// @param cornerRadius 圆角
- (void)setGradientWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors locations:(NSArray*)locations cornerRadius:(CGFloat)cornerRadius;


/// 凸起
/// @param parent view
/// @param lineColor    lineColor
/// @param backgroundColor  backgroundColor
+ (UIView*)addTopViewToParentView:(UIView*)parent topLineColor:(UIColor*)lineColor backgroundColor:(UIColor*)backgroundColor;
@end

NS_ASSUME_NONNULL_END
