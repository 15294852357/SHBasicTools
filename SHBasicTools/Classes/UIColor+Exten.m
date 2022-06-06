//
//  UIColor+Exten.m
//  WisdomPeoples
//
//  Created by 慧 on 2020/12/11.
//  Copyright © 2020 慧. All rights reserved.
//

#import "UIColor+Exten.h"

@implementation UIColor (Exten)

+ (instancetype)cmw_colorGradientChangeWithSize:(CGSize)size direction:(SHGradientDirection)direction startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation startColor:(UIColor *)startcolor endColor:(UIColor *)endColor {
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame            = CGRectMake(0, 0, size.width, size.height);
    CGPoint startPoint             = CGPointZero;
    CGPoint endPoint               = CGPointZero;
    if (direction == SHGradientDirectionUp) {
        endPoint = CGPointMake(0, 1);
    } else if (direction == SHGradientDirectionRight) {
        endPoint = CGPointMake(1, 0);
    } else if (direction == SHGradientDirectionDown) {
        endPoint = CGPointMake(0, -1);
    } else if (direction == SHGradientDirectionLeft) {
        endPoint = CGPointMake(-1, 0);
    } else if (direction == (SHGradientDirectionRight | SHGradientDirectionUp)) {
        endPoint = CGPointMake(1, 1);
    } else if ((direction == SHGradientDirectionRight) | SHGradientDirectionDown) {
        endPoint = CGPointMake(1, -1);
    } else if ((direction == SHGradientDirectionLeft) | SHGradientDirectionUp) {
        endPoint = CGPointMake(-1, 1);
    } else if (direction == (SHGradientDirectionLeft | SHGradientDirectionDown)) {
        endPoint = CGPointMake(-1, -1);
    } else {
        endPoint = CGPointZero;
    }
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint   = endPoint;
    gradientLayer.locations  = @[[NSNumber numberWithFloat:startLocation], [NSNumber numberWithFloat:endLocation]];
    gradientLayer.colors     = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

// 颜色的渐变色
+ (UIColor *)gradientColorImageFromColors:(NSArray<UIColor *> *)colors
                             gradientType:(SHGradientType)gradientType
                                  imgSize:(CGSize)imgSize {
    NSMutableArray *muArray = [NSMutableArray array];
    
    for (UIColor *c in colors) {
        [muArray addObject:(id)c.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)muArray, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case SHGradientTypeTopToBottom: {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        }
        case SHGradientTypeLeftToRight: {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        }
        case SHGradientTypeUpleftToLowright: {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        }
        case SHGradientTypeUprightToLowleft: {
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        }
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor*)colorWithDarkColor:(UIColor*)darkColor  lightColor:(UIColor*)lightColor{
    if (darkColor == nil || lightColor == 0) {
        return [UIColor whiteColor];
    }
    if (@available(iOS 13.0, *)) {
        UIColor * color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection){
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight){
                return lightColor;
            }else if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                return  darkColor;
            }
            return [UIColor whiteColor];
        }];
        return color;
    }
    return [UIColor whiteColor];
}

+ (UIColor*)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
