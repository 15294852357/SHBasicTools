//
//  SHNavigationBar.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHNavigationBar.h"

#define BLNB_PADDING_H 11.0

@implementation SHNavigationBar
@synthesize title, titleView, leftView, righView, labTitle;
@synthesize navBgView;

+ (instancetype)sharedInit {
    static SHNavigationBar *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Life Cycle
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, APP_NavBarHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        navBgView = [[UIImageView alloc] init];
        navBgView.userInteractionEnabled = YES;
        [self addSubview:navBgView];

        labTitle = [[UILabel alloc] init];
        labTitle.backgroundColor = [UIColor clearColor];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.font = [UIFont boldSystemFontOfSize:18.0f];
        labTitle.textColor = [UIColor blackColor];
        [self addSubview:labTitle];
        self.labTitle = labTitle;

        container = [[UIView alloc] init];
        container.backgroundColor = [UIColor clearColor];
        [self addSubview:container];

        lineView = [[UIView alloc] init];
        lineView.backgroundColor = line_Color;
        [self addSubview:lineView];
    }
    return self;
}
#pragma mark - Public Methods
- (void)setTitle:(NSString *)temp {
    if (title != temp) {
        title = temp;
    }
    if (titleView == nil) {
        labTitle.hidden = NO;
    }
    labTitle.text = title;
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor {
    labTitle.textColor = titleColor;
    if (titleColor == nil) {
        labTitle.textColor = [UIColor blackColor];
    }
}

- (void)setLineHidden:(BOOL)lineHidden {
    _lineHidden = lineHidden;
    lineView.hidden = _lineHidden;
}

- (void)setIsRootViewCon:(BOOL)isRootViewCon{
    _isRootViewCon = isRootViewCon;
    if (isRootViewCon == YES) {
        self.leftView.hidden = YES;
    }else{
        self.leftView.hidden = NO;
    }
}

- (void)setTitleView:(UIView *)temp {
    if (titleView != temp) {
        [titleView removeFromSuperview];
        titleView = temp;
        [container addSubview:titleView];
    }
    labTitle.hidden = YES;

    [self setNeedsLayout];
}

- (void)setRighView:(UIView *)temp {
    if (righView != temp) {
        [righView removeFromSuperview];
        righView = temp;
        [self addSubview:righView];
    }
    [self setNeedsLayout];
}

- (void)setLeftView:(UIView *)temp {
    if (leftView != temp) {
        [leftView removeFromSuperview];
        leftView = temp;
        [self addSubview:leftView];
    }
    [self setNeedsLayout];
}

- (void)setTitleLabelLeft:(CGFloat)titleLabelLeft {
    _titleLabelLeft = titleLabelLeft;    
    [self setNeedsLayout];
}

- (void)setTitleViewOffset:(CGFloat)titleViewOffset {
    _titleViewOffset = titleViewOffset;
    [self setNeedsLayout];
}
#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize vsize = self.bounds.size;
    navBgView.frame = self.bounds;

    if (leftView) {
        CGRect left = leftView.frame;
        left.origin.x = 0.0f;
        left.origin.y = (vsize.height - left.size.height - APP_STATUSBAR_HEIGHT) / 2.0f + APP_STATUSBAR_HEIGHT;
        leftView.frame = left;
    }

    if (righView) {
        CGRect right = righView.frame;
        right.origin.x = vsize.width - right.size.width - 15.0f;
        right.origin.y = (vsize.height - right.size.height - APP_STATUSBAR_HEIGHT) / 2.0f + APP_STATUSBAR_HEIGHT;
        righView.frame = right;
    }

    CGRect ctn = CGRectMake(60.0f, 0.0f, 200.0f, vsize.height);
    if (leftView) {
        ctn.origin.x = MAX(60.0f, CGRectGetMaxX(leftView.frame) + BLNB_PADDING_H);
    }
    if (righView) {
        ctn.size.width = CGRectGetMinX(righView.frame) - ctn.origin.x - BLNB_PADDING_H;
    } else {
        ctn.size.width = vsize.width - ctn.origin.x - BLNB_PADDING_H;
    }
    container.frame = ctn;

    labTitle.frame = CGRectMake(60.0f + _titleLabelLeft, APP_STATUSBAR_HEIGHT, vsize.width - 120.0f - _titleLabelLeft, vsize.height - APP_STATUSBAR_HEIGHT + _titleViewOffset);

    if (titleView) {
        titleView.center = CGPointMake(100.0f + (keySCREEN_WIDTH - 320) / 2, (vsize.height - APP_STATUSBAR_HEIGHT) / 2.0f + APP_STATUSBAR_HEIGHT);
    }

    CGFloat lineH  = 0.5;
    lineView.frame = CGRectMake(0, vsize.height - lineH, vsize.width, lineH);
}

+ (UIButton *)backButtonTarget:(id)target action:(SEL)sel backImageString:(NSString*)backImageString{
    UIButton *bleft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CONVER_VALUE(44.0f), CONVER_VALUE(44.0f))];
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"SHNavigationBar")];
    bleft.tag = 200;
    [bleft setImage:[UIImage imageNamed:backImageString inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [bleft addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return bleft;
}

+ (SHNavigationBar *)navBarWithTitle:(NSString *)title backButton:(id)target action:(SEL)sel {
    SHNavigationBar *navbar = [[SHNavigationBar alloc] init];
    if (target) {
//        navbar.leftView = [SHNavigationBar backButtonTarget:target action:sel backImageString:@"back_withe"];
    }
    navbar.title = title;
    return navbar;
}

@end
