//
//  UIView+Exten.m
//  WisdomPeoples
//
//  Created by 慧 on 2022/5/5.
//  Copyright © 2020 慧. All rights reserved.
//

#import "UIView+Exten.h"

@implementation UIView (Exten)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size;{
  CGPoint origin = [self frame].origin;
  
  [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;{
  return [self frame].size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)left{
  return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x{
  CGRect frame = [self frame];
  frame.origin.x = x;
  [self setFrame:frame];
}

- (CGFloat)top{
  return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y{
  CGRect frame = [self frame];
  frame.origin.y = y;
  [self setFrame:frame];
}

- (CGFloat)right{
  return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right{
  CGRect frame = [self frame];
  frame.origin.x = right - frame.size.width;
  
  [self setFrame:frame];
}

- (CGFloat)bottom{
  return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom{
  CGRect frame = [self frame];
  frame.origin.y = bottom - frame.size.height;

  [self setFrame:frame];
}

- (CGFloat)centerX{
  return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX{
  [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY{
  return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY{
  [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)width{
  return CGRectGetWidth([self frame]);
}

- (void)setWidth:(CGFloat)width{
  CGRect frame = [self frame];
  frame.size.width = width;

  [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)height{
  return CGRectGetHeight([self frame]);
}

- (void)setHeight:(CGFloat)height{
  CGRect frame = [self frame];
  frame.size.height = height;
    
  [self setFrame:CGRectStandardize(frame)];
}

- (CGSize)boundsSize{
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)size{
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)boundsWidth{
    return self.boundsSize.width;
}

- (void)setBoundsWidth:(CGFloat)width{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight{
    return self.boundsSize.height;
}

- (void)setBoundsHeight:(CGFloat)height{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (CGRect)contentBounds{
    return CGRectMake(0.0f, 0.0f, self.boundsWidth, self.boundsHeight);
}

- (CGPoint)contentCenter{
    return CGPointMake(self.boundsWidth/2.0f, self.boundsHeight/2.0f);
}

- (void)setLeft:(CGFloat)left right:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = right - left;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width right:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - width;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - height;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
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

- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.cornerRadius = cornerRadius;
}

-(void)setShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(SHShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius =  shadowRadius;
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = self.bounds.size.width;
    CGFloat originH = self.bounds.size.height;
    switch (shadowPathSide) {
        case SHShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case SHShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
        case SHShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case SHShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case SHShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case SHShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
          }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

//- (void)setShoawWithColor:(UIColor*)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius{
//    self.layer.shadowColor = color.CGColor;
//    self.layer.shadowOffset = shadowOffset;
//    self.layer.shadowOpacity = shadowOpacity;
//    self.layer.shadowRadius = shadowRadius;
//}

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


+ (void)setTabelViewCellWithRadius:(CGFloat)radius cell:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath tableView:(UITableView *)tableView{
    // 圆角弧度半径
    CGFloat cornerRadius = radius;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = clear_Color;
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = clear_Color;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
}

+ (UIView*)addTopViewToParentView:(UIView*)parent topLineColor:(UIColor*)lineColor backgroundColor:(UIColor*)backgroundColor{

    UIBezierPath *path = [UIBezierPath bezierPath];

    CGPoint p0 = CGPointMake(0.0, 20);
    CGPoint p1 = CGPointMake(parent.bounds.size.width/2.0 - 65, 20);
    CGPoint p = CGPointMake(parent.bounds.size.width/2.0, 0);
    CGPoint p2 = CGPointMake(parent.bounds.size.width/2.0 + 65, 20);
    CGPoint p3 = CGPointMake(parent.bounds.size.width, 20);

    NSValue *v0 = [NSValue valueWithCGPoint:p0];
    NSValue *v1 = [NSValue valueWithCGPoint:p1];
    NSValue * v = [NSValue valueWithCGPoint:p];
    NSValue *v2 = [NSValue valueWithCGPoint:p2];
    NSValue *v3 = [NSValue valueWithCGPoint:p3];

    NSArray *array = [NSArray arrayWithObjects:v0,  v1, v, v2, v3, nil];

    [path moveToPoint:p0];

    for (NSInteger i=0; i<array.count - 3; i++) {
        CGPoint t0 = [array[i+0] CGPointValue];
        CGPoint t1 = [array[i+1] CGPointValue];
        CGPoint t2 = [array[i+2] CGPointValue];
        CGPoint t3 = [array[i+3] CGPointValue];

        for (int i=0; i<100; i++) {
            CGFloat t = i/100.0;
            CGPoint point = [[self class] getPoint:t p0:t0 p1:t1 p2:t2 p3:t3];
            [path addLineToPoint:point];
        }
    }

    [path addLineToPoint:p3];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.frame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    shapeLayer.lineWidth = 0.5;
    shapeLayer.lineCap = @"round";
    shapeLayer.strokeColor = [lineColor CGColor];
    shapeLayer.fillColor = [backgroundColor CGColor];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = 1.0;
    [parent.layer addSublayer:shapeLayer];
    parent.userInteractionEnabled = NO;
    return parent;
}
/**
 Catmull-Rom算法
 根据四个点计算中间点
 */
+ (CGPoint)getPoint:(CGFloat)t p0:(CGPoint)p0 p1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 {
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    
    CGFloat f0 = -0.5*t3 + t2 - 0.5*t;
    CGFloat f1 = 1.5*t3 - 2.5*t2 + 1.0;
    CGFloat f2 = -1.5*t3 + 2.0*t2 + 0.5*t;
    CGFloat f3 = 0.5*t3 - 0.5*t2;
    
    CGFloat x = p0.x*f0 + p1.x*f1 + p2.x*f2 +p3.x*f3;
    CGFloat y = p0.y*f0 + p1.y*f1 + p2.y*f2 +p3.y*f3;
    
    return CGPointMake(x, y);
}

@end
