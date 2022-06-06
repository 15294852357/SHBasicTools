//
//  AlertView.m
//  SHBasicTools
//
//  Created by 慧 on 2022/5/31.
//

#import "AlertView.h"

@implementation AlertView

- (instancetype)initTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(keySCREEN_WIDTH / 2 - 115, keySCREEN_HEIGHT / 2 - 100, 230, 70);
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.label1 = [[UILabel alloc]init];
        self.label1.text = [NSString StringConverWithString:title];
        self.label1.numberOfLines = 0;
        self.label1.adjustsFontSizeToFitWidth = YES;
        self.label1.textColor = UIColorFromRGBAlpha(0xffffff, 1);
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
        [self addSubview: self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(- 5);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(40);
        }];
        [self show];
    }
    return self;
}

- (instancetype)initTitle:(NSString *)title AndContent:(NSString *)content AndSureBtn:(NSString *)sureStr{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, keySCREEN_WIDTH, keySCREEN_HEIGHT);
        
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = black_Color;
        self.bgView.alpha = 0.3;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        UIView *showView = [[UIView alloc]init];
        showView.layer.masksToBounds = YES;
        showView.backgroundColor = white_Color;
        showView.layer.cornerRadius = 8;
        [self addSubview:showView];
        [showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(keySCREEN_WIDTH - 40);
            make.centerY.mas_equalTo(self.mas_centerY).offset(- 150 / 4);
            make.height.mas_equalTo(150);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = UIColorFromRGBAlpha(0x555555, 1);
        label.textAlignment = NSTextAlignmentCenter;
        [showView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = content;
        label1.numberOfLines = 0;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.textColor = UIColorFromRGBAlpha(0x555555, 1);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:15];
        [showView addSubview: label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(- 10);
            make.top.mas_equalTo(label.mas_bottom);
            make.height.mas_equalTo(60);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = bg_Color;
        [showView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(label1.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        self.sureBtn = [[UIButton alloc]init];
        [self.sureBtn setTitle:sureStr forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

- (instancetype)initContent:(NSString *)content AndSureBtn:(NSString *)sureStr AndCancleStr:(NSString *)cancleStr{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, keySCREEN_WIDTH, keySCREEN_HEIGHT);
        
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = black_Color;
        self.bgView.alpha = 0.3;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];

        UIView *showView = [[UIView alloc]init];
        showView.layer.masksToBounds = YES;
        showView.backgroundColor = white_Color;
        showView.layer.cornerRadius = 8;
        [self addSubview:showView];
        [showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(keySCREEN_WIDTH - 40);
            make.centerY.mas_equalTo(self.mas_centerY).offset(- 120 / 2);
            make.height.mas_equalTo(120);
        }];

        UILabel *label = [[UILabel alloc]init];
        label.text = content;
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = UIColorFromRGBAlpha(0x555555, 1);
        label.textAlignment = NSTextAlignmentCenter;
        [showView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(70);
        }];

        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = bg_Color;
        [showView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(label.mas_bottom);
            make.height.mas_equalTo(1);
        }];

        self.cancleBtn = [[UIButton alloc]init];
        [self.cancleBtn setTitle:cancleStr forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:UIColorFromRGBAlpha(0x979797, 1) forState:UIControlStateNormal];
        self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancleBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(showView.mas_centerX).offset(- 0.5);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(44);
        }];

        UIView *lineView1 = [[UIView alloc]init];
        lineView1.backgroundColor = bg_Color;
        [showView addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cancleBtn.mas_right);
            make.width.mas_equalTo(1);
            make.centerY.mas_equalTo(self.cancleBtn.mas_centerY);
            make.height.mas_equalTo(25);
        }];

        self.sureBtn = [[UIButton alloc]init];
        [self.sureBtn setTitle:sureStr forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView1.mas_right);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.cancleBtn.mas_top);
            make.height.mas_equalTo(self.cancleBtn.mas_height);
        }];
    }
    return self;
}

- (instancetype)initBlackViewAndContent:(NSString *)content AndtTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, keySCREEN_WIDTH, keySCREEN_HEIGHT);
        
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = black_Color;
        self.bgView.alpha = 0.3;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];

        UIView *showView = [[UIView alloc]init];
        showView.layer.masksToBounds = YES;
        showView.backgroundColor = white_Color;
        showView.layer.cornerRadius = 8;
        [self addSubview:showView];
        [showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(keySCREEN_WIDTH - 40);
            make.centerY.mas_equalTo(self.mas_centerY).offset(- 160 / 2);
            make.height.mas_equalTo(160);
        }];

        UILabel *label = [[UILabel alloc]init];
        label.text = content;
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = UIColorFromRGBAlpha(0x555555, 1);
        label.textAlignment = NSTextAlignmentCenter;
        [showView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(- 20);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(80);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = bg_Color;
        [showView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(label.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        self.sureBtn = [[UIButton alloc]init];
        [self.sureBtn setTitle:title forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

- (void)sureBtnClick{
    [self removeFromSuperview];
}

- (void)show{
    [UIView animateKeyframesWithDuration:0 delay:2 options:(UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
