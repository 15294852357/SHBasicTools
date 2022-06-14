//
//  SHTabBar.m
//  JXAoBo
//
//  Created by 慧 on 2020/12/10.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHTabBar.h"

@interface SHTabBar ()
@end

@implementation SHTabBar

+ (instancetype)sharedInit {
    static SHTabBar *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTranslucent:NO];
        
        self.tintColor = Main_Color;
        
        [self addSubview:self.middleBtn];
        [self.middleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:CONVER_VALUE(20.0f)];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
        
    //凸起
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            if ([obj viewWithTag:999] == nil) {                
                UIImageView* topImageView = [[UIImageView alloc] init];
                topImageView.contentMode = UIViewContentModeScaleAspectFill;
                topImageView.image = kGetImage(@"tab_white");
                topImageView.tag = 999;
                [obj addSubview:topImageView];
                [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(CONVER_VALUE(375.0f));
                    make.centerX.mas_equalTo(obj.mas_centerX);
                    make.top.mas_equalTo(CONVER_VALUE(- 20.0f));
                    make.height.mas_equalTo(CONVER_VALUE(20.0f));
                }];
            }
        }
    }];
    
//    UIView* tabarView = [[UIView alloc] init];
//    tabarView.backgroundColor = white_Color;
//    tabarView.frame = CGRectMake(0,0,keySCREEN_WIDTH, APP_TabBarHeight);
//    [tabarView setShoawWithColor:UIColorFromRGBAlpha(0xcccccc, 1) shadowOffset:CGSizeMake(0, -3) shadowOpacity:0.3 shadowRadius:3 cornerRadius:0];
//    self.opaque = YES;
//    [self insertSubview:tabarView atIndex:0];

    NSInteger count = self.subviews.count;
    for (NSInteger i = 0, j = 0; i < count; i ++) {
        UIView* view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / 5;
            view.x = self.width * j / 5;
            j ++;
            if (j == 2) {
                j ++;
            }
        }
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.middleBtn];
        if ([self.middleBtn pointInside:newP withEvent:event]) {
            return self.middleBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

- (UIButton *)middleBtn{
    if (!_middleBtn) {
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.size = CGSizeMake(keySCREEN_WIDTH / 5, 70);
        _middleBtn.centerX = keySCREEN_WIDTH / 2;
        _middleBtn.top = 0;
    }
    return _middleBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
