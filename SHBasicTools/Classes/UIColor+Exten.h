//
//  UIColor+Exten.h
//  WisdomPeoples
//
//  Created by 慧 on 2020/12/11.
//  Copyright © 2020 慧. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, SHGradientDirection) {
    SHGradientDirectionUp    = 1 << 0,
    SHGradientDirectionRight = 1 << 1,
    SHGradientDirectionDown  = 1 << 2,
    SHGradientDirectionLeft  = 1 << 3,
};

typedef NS_ENUM(NSUInteger, SHGradientType) { // 渐变方向
    SHGradientTypeTopToBottom      = 1 << 0, // 从上到下
    SHGradientTypeLeftToRight      = 1 << 1, // 从左到右
    SHGradientTypeUpleftToLowright = 1 << 2, // 左上到右下
    SHGradientTypeUprightToLowleft = 1 << 3  // 右上到左下
};

@interface UIColor (Exten)

+ (instancetype)cmw_colorGradientChangeWithSize:(CGSize)size direction:(SHGradientDirection)direction startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation startColor:(UIColor *)startcolor endColor:(UIColor *)endColor;

/**
 颜色的渐变色
 
 @param colors UIColor数组
 @param gradientType 渐变方式
 @param imgSize 图片大小
 @return 转换后的渐变色
 */
+ (UIColor *)gradientColorImageFromColors:(NSArray<UIColor *> *)colors gradientType:(SHGradientType)gradientType imgSize:(CGSize)imgSize;


+ (UIColor*)colorWithDarkColor:(UIColor*)darkColor  lightColor:(UIColor*)lightColor;

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor*)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
