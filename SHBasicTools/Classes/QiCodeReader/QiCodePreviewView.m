//
//  QiCodePreviewView.m
//  QiQRCode
//
//  Created by huangxianshuai on 2018/11/13.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiCodePreviewView.h"

@interface QiCodePreviewView ()

@property (nonatomic, strong) CAShapeLayer *rectLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CABasicAnimation *lineAnimation;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIButton *torchSwithButton;
@end

@implementation QiCodePreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    return [[QiCodePreviewView alloc] initWithFrame:frame rectFrame:CGRectZero rectColor:[UIColor clearColor]];
}

- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor {
    return [[QiCodePreviewView alloc] initWithFrame:frame rectFrame:CGRectZero rectColor:rectColor];
}

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame {
    return [[QiCodePreviewView alloc] initWithFrame:frame rectFrame:rectFrame rectColor:[UIColor clearColor]];
}

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor {
    self = [super initWithFrame:frame];
    if (self) {
        if (CGRectEqualToRect(rectFrame, CGRectZero)) {
            CGFloat rectSide = fminf(self.layer.bounds.size.width, self.layer.bounds.size.height) * 2 / 3;
            rectFrame = CGRectMake((self.layer.bounds.size.width - rectSide) / 2, (self.layer.bounds.size.height - rectSide) / 2, rectSide, rectSide);
        }
        if (CGColorEqualToColor(rectColor.CGColor, [UIColor clearColor].CGColor)) {
            rectColor = [UIColor whiteColor];
        }
        // 根据自定义的rectFrame画矩形框（扫码框）
        [self.layer masksToBounds];
        [self clipsToBounds];
        
        CGFloat lineWidth = .5;
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:(CGRect){lineWidth / 2, lineWidth / 2, rectFrame.size.width - lineWidth, rectFrame.size.height - lineWidth}];
        CAShapeLayer* rectLayer = [CAShapeLayer layer];
        rectLayer.fillColor = [UIColor clearColor].CGColor;
        rectLayer.strokeColor = rectColor.CGColor;
        rectLayer.path = rectPath.CGPath;
        rectLayer.lineWidth = lineWidth;
        rectLayer.frame = rectFrame;
        [self.layer addSublayer:rectLayer];
        self.rectLayer = rectLayer;
        
        // 根据rectFrame创建矩形拐角路径
        CGFloat cornerWidth = 2.0;
        CGFloat cornerLength = fminf(rectFrame.size.width, rectFrame.size.height) / 12;
        UIBezierPath *cornerPath = [UIBezierPath bezierPath];
        // 左上角
        [cornerPath moveToPoint:(CGPoint){cornerWidth / 2, .0}];
        [cornerPath addLineToPoint:(CGPoint){cornerWidth / 2, cornerLength}];
        [cornerPath moveToPoint:(CGPoint){.0, cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){cornerLength, cornerWidth / 2}];
        // 右上角
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width, cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerLength, cornerWidth / 2}];
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, .0}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, cornerLength}];
        // 右下角
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, rectFrame.size.height}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerWidth / 2, rectFrame.size.height - cornerLength}];
        [cornerPath moveToPoint:(CGPoint){rectFrame.size.width, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){rectFrame.size.width - cornerLength, rectFrame.size.height - cornerWidth / 2}];
        // 左下角
        [cornerPath moveToPoint:(CGPoint){.0, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath addLineToPoint:(CGPoint){cornerLength, rectFrame.size.height - cornerWidth / 2}];
        [cornerPath moveToPoint:(CGPoint){cornerWidth / 2, rectFrame.size.height}];
        [cornerPath addLineToPoint:(CGPoint){cornerWidth / 2, rectFrame.size.height - cornerLength}];
        
        // 根据矩形拐角路径画矩形拐角
        CAShapeLayer* cornerLayer = [CAShapeLayer layer];
        cornerLayer.frame = rectFrame;
        cornerLayer.path = cornerPath.CGPath;
        cornerLayer.lineWidth = cornerPath.lineWidth;
        cornerLayer.strokeColor = rectColor.CGColor;
        [self.layer addSublayer:cornerLayer];
        
        // 遮罩+镂空
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
        UIBezierPath *subPath = [[UIBezierPath bezierPathWithRect:rectFrame] bezierPathByReversingPath];
        [maskPath appendPath:subPath];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor colorWithWhite:.0 alpha:.6].CGColor;
        maskLayer.path = maskPath.CGPath;
        [self.layer addSublayer:maskLayer];
        
        // 根据rectFrame画扫描线
        CGRect lineFrame = (CGRect){rectFrame.origin.x + 5.0, rectFrame.origin.y, rectFrame.size.width - 5.0 * 2, 1.5};
        UIBezierPath *linePath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){.0, .0, lineFrame.size.width, lineFrame.size.height}];
        CAShapeLayer* lineLayer = [CAShapeLayer layer];
        lineLayer.frame = lineFrame;
        lineLayer.path = linePath.CGPath;
        lineLayer.fillColor = rectColor.CGColor;
        lineLayer.shadowColor = rectColor.CGColor;
        lineLayer.shadowRadius = 5.0;
        lineLayer.shadowOffset = CGSizeMake(.0, .0);
        lineLayer.shadowOpacity = 1.0;
        lineLayer.hidden = YES;
        [self.layer addSublayer:lineLayer];
        self.lineLayer = lineLayer;
        
        // 扫描线动画
        CABasicAnimation* lineAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        lineAnimation.fromValue = [NSValue valueWithCGPoint:(CGPoint){lineLayer.frame.origin.x + lineLayer.frame.size.width / 2, rectFrame.origin.y + lineLayer.frame.size.height}];
        lineAnimation.toValue = [NSValue valueWithCGPoint:(CGPoint){lineLayer.frame.origin.x + lineLayer.frame.size.width / 2, rectFrame.origin.y + rectFrame.size.height - lineLayer.frame.size.height}];
        lineAnimation.repeatCount = CGFLOAT_MAX;
        lineAnimation.autoreverses = YES;
        lineAnimation.duration = 2.0;
        self.lineAnimation = lineAnimation;
        
        // 手电筒开关
        UIButton* torchSwithButton = [UIButton buttonWithType:UIButtonTypeCustom];
        torchSwithButton.frame = CGRectMake(.0, .0, 60.0, 70.0);
        torchSwithButton.center = CGPointMake(CGRectGetMidX(rectFrame), CGRectGetMaxY(rectFrame) - CGRectGetMidY(torchSwithButton.bounds));
        torchSwithButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [torchSwithButton setTitle:@"轻触照亮" forState:UIControlStateNormal];
        [torchSwithButton setTitle:@"轻触关闭" forState:UIControlStateSelected];
        [torchSwithButton setImage:[UIImage imageNamed:@"qi_torch_switch_off"] forState:UIControlStateNormal];
        [torchSwithButton setImage:[[UIImage imageNamed:@"qi_torch_switch_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
        [torchSwithButton addTarget:self action:@selector(torchSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];
        torchSwithButton.tintColor = rectColor;
        torchSwithButton.hidden = YES;
//        [torchSwithButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:CONVER_VALUE(3.0f)];
        [self addSubview:torchSwithButton];
        self.torchSwithButton = torchSwithButton;
        
        // 提示语label
        UILabel* tipsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tipsLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:.6];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.font = [UIFont systemFontOfSize:13.0];
        tipsLabel.text = @"将二维码/条形码放入框内即可自动扫描";
        tipsLabel.numberOfLines = 0;
        [tipsLabel sizeToFit];
        tipsLabel.center = CGPointMake(CGRectGetMidX(rectFrame), CGRectGetMaxY(rectFrame) + CGRectGetMidY(tipsLabel.bounds)+ 12.0);
        [self addSubview:tipsLabel];
        
        // 等待指示view
        UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:rectFrame];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        indicatorView.hidesWhenStopped = YES;
        [self addSubview:indicatorView];
        self.indicatorView = indicatorView;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
#pragma mark - Public functions
- (CGRect)rectFrame {
    return self.rectLayer.frame;
}

- (void)startScanning {
    self.lineLayer.hidden = NO;
    [self.lineLayer addAnimation:self.lineAnimation forKey:@"lineAnimation"];
}

- (void)stopScanning {
    self.lineLayer.hidden = YES;
    [self.lineLayer removeAnimationForKey:@"lineAnimation"];
}

- (void)startIndicating {
    [self.indicatorView stopAnimating];
}

- (void)stopIndicating {
    [self.indicatorView stopAnimating];
}

- (void)showTorchSwitch {
    self.torchSwithButton.hidden = NO;
    self.torchSwithButton.alpha = .0;
    [UIView animateWithDuration:.25 animations:^{
        self.torchSwithButton.alpha = 1.0;
    }];
}

- (void)hideTorchSwitch {
    [UIView animateWithDuration:.1 animations:^{
        self.torchSwithButton.alpha = .0;
    } completion:^(BOOL finished) {
        self.torchSwithButton.hidden = YES;
    }];
}
#pragma mark - Private functions
- (void)didAddSubview:(UIView *)subview {
    if (subview == self.indicatorView) {
        [self.indicatorView startAnimating];
    }
}
#pragma mark - Action functions
- (void)torchSwitchClicked:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(codeScanningView:didClickedTorchSwitch:)]) {
        [_delegate codeScanningView:self didClickedTorchSwitch:button];
    }
}
@end
