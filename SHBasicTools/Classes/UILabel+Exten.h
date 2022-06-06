//
//  UILabel.h
//  XiaoXingQiangDan
//
//  Created by 慧 on 2019/5/31.
//  Copyright © 2019 朱华峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    myVerticalAlignmentNone = 0,
    myVerticalAlignmentCenter,
    myVerticalAlignmentTop,
    myVerticalAlignmentBottom

}myVerticalAlignment;

@interface UILabel (Exten)

@property (nonatomic,assign) CGFloat topInset;
@property (nonatomic,assign) CGFloat leftInset;
@property (nonatomic,assign) CGFloat bottomInset;
@property (nonatomic,assign) CGFloat rightInset;
@property (nonatomic,assign) myVerticalAlignment verticalAlignment;

/// 设置某边边框
- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/// 设置圆角
- (void)setRoundedCornersWithRectCorner:(UIRectCorner)rectCorner cornerSize:(CGSize)cornerSize;

/// 阴影
/// @param color 颜色
/// @param shadowOffset 阴影偏移,x向右，y向下，默认(0, -3),这个跟shadowRadius配合使用
/// @param shadowOpacity 阴影透明度，默认0
/// @param shadowRadius 阴影半径，默认3
- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

/// 渐变
/// @param startPoint startPoint与endPoint分别为渐变的起始方向与结束方向，它是以矩形的四个角为基础的，（0，0）为左上角、（1，0）为右上角、（0，1）为左下角、（1，1）为右下角，默认是值是（0.5，0）和（0.5，1
/// @param endPoint 结束方向
/// @param colors 颜色属于CGColorRef类，所以必须加CGColor，而且前面还要加(id)
/// @param locations 渐变颜色的区间分布，locations的数组长度和color一致也可以不一致，这个值一般不用管它，默认是nil，会平均分布
/// @param cornerRadius 圆角
- (void)setGradientWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors locations:(NSArray*)locations cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
