//
//  VersionView.m
//  WisdomPeoples
//
//  Created by 慧 on 2018/12/26.
//  Copyright © 2018年 慧. All rights reserved.
//

#import "VersionView.h"

@implementation VersionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* bgView = [[UIView alloc]init];
        bgView.backgroundColor = UIColorFromRGBAlpha(0x000000, 0.6);
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
//        UIView* whiteView = [[UIView alloc] init];
//        whiteView.backgroundColor = white_Color;
//        [self addSubview:whiteView];
//        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.centerY.mas_equalTo(self.mas_centerY);
//            make.width.mas_equalTo(CONVER_VALUE(275.0f));
//            make.height.mas_equalTo(CONVER_VALUE(370.0f));
//        }];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = kGetImage(@"update_bg");
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(CONVER_VALUE(240.0f));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(CONVER_VALUE(375.0f));
        }];
        
//        UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        closeButton.contentMode = UIViewContentModeScaleAspectFit;
//        [closeButton setBackgroundImage:[UIImage imageNamed:@"update_close"] forState:UIControlStateNormal];
//        [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:closeButton];
//        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(imageView.mas_centerX);
//            make.width.height.mas_equalTo(CONVER_VALUE(25.0f));
//            make.top.mas_equalTo(imageView.mas_bottom).offset(CONVER_VALUE(10.0f));
//        }];
                
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"新版本抢先体验" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGBAlpha(0x2D2A2B, 1) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:CONVER_VALUE(22.0f)];
        [button setImage:kGetImage(@"update_new") forState:UIControlStateNormal];
//        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:CONVER_VALUE(5.0f)];
        button.userInteractionEnabled = NO;
        [imageView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(CONVER_VALUE(165.0f));
            make.height.mas_equalTo(CONVER_VALUE(25.0f));
        }];

        UILabel* versionLabel = [[UILabel alloc] init];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        versionLabel.textColor = white_Color;
        versionLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(12.0f)];
        versionLabel.backgroundColor = UIColorFromRGBAlpha(0xFD5841, 1);
        versionLabel.layer.cornerRadius = CONVER_VALUE(8.0f);
        versionLabel.layer.masksToBounds = YES;
        [imageView addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CONVER_VALUE(52.0f));
            make.height.mas_equalTo(CONVER_VALUE(16.0f));
            make.bottom.mas_equalTo(button.mas_top).offset(CONVER_VALUE(-10.0f));
            make.centerX.mas_equalTo(imageView.mas_centerX);
        }];
        self.versionLabel = versionLabel;

        UITextView* textView = [[UITextView alloc]init];
        textView.backgroundColor = clear_Color;
        textView.textColor = UIColorFromRGBAlpha(0x4D4B4C, 1);
        textView.font = [UIFont systemFontOfSize:CONVER_VALUE(12.0f)];
        textView.editable = NO;
        [imageView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(CONVER_VALUE(15.0f));
            make.right.mas_equalTo(CONVER_VALUE(- 15.0f));
            make.top.mas_equalTo(button.mas_bottom);
            make.bottom.mas_equalTo(CONVER_VALUE(- 60.0f));
        }];
        self.textView = textView;
        
//        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelButton setTitle:@"稍后再说" forState:UIControlStateNormal];
//        [cancelButton setTitleColor:Main_Color forState:UIControlStateNormal];
//        cancelButton.titleLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(12.0f)];
//        cancelButton.layer.cornerRadius = CONVER_VALUE(17.0f);
//        cancelButton.layer.masksToBounds = YES;
//        cancelButton.layer.borderColor = Main_Color.CGColor;
//        cancelButton.layer.borderWidth = CONVER_VALUE(0.5f);
//        [cancelButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [imageView addSubview:cancelButton];
//        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(textView.left);
//            make.width.mas_equalTo(CONVER_VALUE(90.0f));
//            make.height.mas_equalTo(CONVER_VALUE(34.0f));
//            make.bottom.mas_equalTo(CONVER_VALUE(- 20.0f));
//        }];

        UIButton* updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
        [updateButton setTitleColor:white_Color forState:UIControlStateNormal];
        [updateButton setBackgroundColor:Main_Color];
        updateButton.titleLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(12.0f)];
        updateButton.layer.cornerRadius = CONVER_VALUE(17.0f);
        updateButton.layer.masksToBounds = YES;
        [imageView addSubview:updateButton];
        [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(textView);
            make.height.mas_equalTo(CONVER_VALUE(34.0f));
            make.bottom.mas_equalTo(CONVER_VALUE(- 20.0f));
        }];
        self.updateButton = updateButton;
    }
    return self;
}

- (void)closeButtonClick:(UIButton*)button{
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
