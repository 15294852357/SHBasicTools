//
//  UILabel.m
//  XiaoXingQiangDan
//
//  Created by 慧 on 2019/5/31.
//  Copyright © 2019 朱华峰. All rights reserved.
//

#import "UILabel+Exten.h"
#import <objc/runtime.h>

NSString const *topInsetKey = @"topInsetKey";
NSString const *leftInsetKey = @"leftInsetKey";
NSString const *bottomInsetKey = @"bottomInsetKey";
NSString const *rightInsetKey = @"rightInsetKey";

NSString const *verticalAlignmentKey = @"verticalAlignmentKey";

@implementation UILabel (Exten)

- (CGFloat)topInset{
    NSNumber *number = objc_getAssociatedObject(self, &topInsetKey);
    return number.floatValue;
}

- (void)setTopInset:(CGFloat)topInset{
    NSNumber *number = [NSNumber numberWithDouble:topInset];
    objc_setAssociatedObject(self, &topInsetKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)leftInset {
    NSNumber *number = objc_getAssociatedObject(self, &leftInsetKey);
    return number.floatValue;
}

- (void)setLeftInset:(CGFloat)leftInset{
    NSNumber *number = [NSNumber numberWithDouble:leftInset];
    objc_setAssociatedObject(self, &leftInsetKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)bottomInset {
    NSNumber *number = objc_getAssociatedObject(self, &bottomInsetKey);
    return number.floatValue;
}

- (void)setBottomInset:(CGFloat)bottomInset{
    NSNumber *number = [NSNumber numberWithDouble:bottomInset];
    objc_setAssociatedObject(self, &bottomInsetKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)rightInset {
    NSNumber *number = objc_getAssociatedObject(self, &rightInsetKey);
    return number.floatValue;
}

- (void)setRightInset:(CGFloat)rightInset{
    NSNumber *number = [NSNumber numberWithDouble:rightInset];
    objc_setAssociatedObject(self, &rightInsetKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//- (myVerticalAlignment)verticalAlignment{
//    NSNumber *number = objc_getAssociatedObject(self, &verticalAlignmentKey);
//    return number.integerValue;
//}
//
//- (void)setVerticalAlignment:(myVerticalAlignment)verticalAlignment{
//    NSNumber *number = [NSNumber numberWithDouble:verticalAlignment];
//    objc_setAssociatedObject(self, &verticalAlignmentKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self setNeedsDisplay];
//}
 
/**
 消除警告⚠️1⃣️
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
    代码
 #pragma clang diagnostic pop

 消除警告⚠️2⃣️
 build settings下  搜索other warning flags  然后给其添加 -Wno-objc-protocol-method-implementation
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//- (void)drawTextInRect:(CGRect)rect{
//    // ⚠️不起作用
////    UIEdgeInsets inset = {0, self.leftInset, 0, 0};
////    [super drawRect:UIEdgeInsetsInsetRect(rect, inset)];
//
//    if (self.verticalAlignment == myVerticalAlignmentNone){
//        self.adjustsFontSizeToFitWidth = YES;
//        if (self.leftInset == 0) {
//            self.leftInset = CONVER_VALUE(15.0f);
//        }
//        UIEdgeInsets insets = {CONVER_VALUE(0.0f), self.leftInset, CONVER_VALUE(0.0f), CONVER_VALUE(10.0f)};
//        [self drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
//    }else{
//        UIEdgeInsets insets = {CONVER_VALUE(0.0f), self.leftInset, CONVER_VALUE(0.0f), CONVER_VALUE(10.0f)};
//
//        CGRect textRect = [self textRectForBounds:UIEdgeInsetsInsetRect(rect, insets) limitedToNumberOfLines:self.numberOfLines];
//        [self drawTextInRect:textRect];
//    }
//}
//
//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
//    // ⚠️不起作用
//
//    CGRect textRect = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
////    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
//    switch (self.verticalAlignment) {
//        case myVerticalAlignmentTop:
//            textRect.origin.y = bounds.origin.y;
//            break;
//        case myVerticalAlignmentBottom:
//            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
//            break;
//        case myVerticalAlignmentCenter:
//            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
//            break;
//        default:
//            break;
//    }
//    return textRect;
//}
#pragma clang diagnostic pop

- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

- (void)setRoundedCornersWithRectCorner:(UIRectCorner)rectCorner cornerSize:(CGSize)cornerSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}

- (void)setGradientWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors locations:(NSArray*)locations cornerRadius:(CGFloat)cornerRadius{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.startPoint = startPoint;
    gl.endPoint = endPoint;
    gl.colors = colors;
    gl.locations = locations;
    gl.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gl atIndex:0];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
