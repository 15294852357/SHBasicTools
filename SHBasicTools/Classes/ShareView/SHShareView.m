//
//  ShareView.m
//  WisdomPeoples
//
//  Created by 慧 on 2020/12/22.
//  Copyright © 2020 慧. All rights reserved.
//

#import "SHShareView.h"

#define imageSpace  (keySCREEN_WIDTH - CONVER_VALUE(70.0f) * 5) / 6
#define button_width_height CONVER_VALUE(70.0f)

@interface SHShareView (){
    UIView* _whiteView;
}
@end

@implementation SHShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* bgView = [[UIView alloc] init];
        bgView.backgroundColor = black_Color;
        bgView.alpha = 0.3;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];

        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [bgView addGestureRecognizer:tap];

        UIView* whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = white_Color;
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
        }];
        _whiteView = whiteView;

        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = UIColorFromRGBAlpha(0x333333, 1);
        titleLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(16.0f)];
        titleLabel.text = @"分 享 到";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(CONVER_VALUE(45.0f));
        }];

        UIButton* canceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        canceButton.tag = 10099;
        [canceButton setTitle:@"取消" forState:UIControlStateNormal];
        [canceButton setTitleColor:UIColorFromRGBAlpha(0x333333, 1) forState:UIControlStateNormal];
        [canceButton addTarget:self action:@selector(canceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:canceButton];
        [canceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CONVER_VALUE(45.0f));
        }];
    }
    return self;
}

- (void)setShareModelArray:(NSMutableArray *)shareModelArray{
    _shareModelArray = shareModelArray;    
    if (shareModelArray.count <= 0) {
        self.hidden = YES;
    }else{
        [self createShareType];
    }
}

- (void)createShareType{
    for (UIView* subView in _whiteView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton* button = (UIButton*)subView;
            if (button.tag != 10099) {
                [button removeFromSuperview];
            }
        }
    }
    UIButton* nextButton = nil;
    for (int i = 0; i < self.shareModelArray.count; i ++) {
        SHShareModel* model = self.shareModelArray[i];
        NSString* imageString = [NSString stringWithFormat:@"%@%@%@",[HttpUrl url_Server],[HttpUrl url_Server_suffix],[NSString StringConverWithString:model.shareIcon]];

        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentMode = UIViewContentModeScaleAspectFit;
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitle:model.shareName forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(12.0f)];
        [button setTitleColor:UIColorFromRGBAlpha(0x333333, 1) forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(button_width_height);
            if (i < 5) {
                make.top.mas_equalTo(CONVER_VALUE(45.0f));
            }else if (i % 5 == 0){
                make.top.mas_equalTo(nextButton.mas_bottom).offset(CONVER_VALUE(10.0f));
            }else{
                make.top.mas_equalTo(nextButton.mas_top);
            }
            
            if (i % 5 == 0) {
                make.left.mas_equalTo(imageSpace);
            }else{
                make.left.mas_equalTo(nextButton.mas_right).offset(imageSpace);
            }
            if (i == self.shareModelArray.count - 1) {
                make.bottom.mas_equalTo(CONVER_VALUE(- 45.0f));
            }
        }];
        nextButton = button;
        [button setSDImageWithImageString:imageString EdgeInsetsStyle:MKButtonEdgeInsetsStyleTop Radius:0 size:CGSizeMake(CONVER_VALUE(45.0f), CONVER_VALUE(45.0f))];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:CONVER_VALUE(5.0f)];
    }
}

- (void)buttonClick:(UIButton*)button{
    self.image = @"defulf_logo";
    SHShareModel* model = self.shareModelArray[button.tag];
    switch (model.shareType) {
        case SHShareModelTypeComplaints:{
            UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
            UINavigationController *nc = tbc.selectedViewController;
            UIViewController *vc = nc.visibleViewController;
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            vc.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

//            InformationCamplaintViewController *viewCon = [[InformationCamplaintViewController alloc] init];
//            viewCon.model = self.informationModel;
//            [vc.navigationController pushViewController:viewCon animated:YES];
//            for (vc in nc.viewControllers) {
//                if ([vc isKindOfClass:[InformationViewController class]] || [vc isKindOfClass:[YunViewController class]] || [vc isKindOfClass:[MainViewController class]] || [vc isKindOfClass:[ServiceViewController class]] || [vc isKindOfClass:[MineViewController class]]){
//                    vc.hidesBottomBarWhenPushed = NO;
//                }
//            }
        }
            break;
        case SHShareModelTypeCopy:{
            UIPasteboard *appPasteBoard =  [UIPasteboard generalPasteboard];
            NSString *pasteStr = self.urlString;
            [appPasteBoard setString:pasteStr];
            
            AlertView* view = [[AlertView alloc] initTitle:@"复制成功"];
            [self addSubview:view];
        }
            break;
        case SHShareModelTypeWeibo:{
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.title images:kGetImage(self.image) url:[NSURL URLWithString:self.urlString] title:self.text type:SSDKContentTypeWebPage];
            [self shareWeiBoParams:shareParams];
        }
            break;
        case SHShareModelTypeQZone:{
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.text images:kGetImage(self.image) url:[NSURL URLWithString:self.urlString]  title:self.title type:SSDKContentTypeAuto];
            [self shareParams:SSDKPlatformSubTypeQZone parameters:shareParams];
        }
            break;
        case SHShareModelTypeQQFriend:{
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.text images:kGetImage(self.image) url:[NSURL URLWithString:self.urlString]  title:self.title type:SSDKContentTypeAuto];
            [self shareParams:SSDKPlatformSubTypeQQFriend parameters:shareParams];
        }
            break;
        case SHShareModelTypeWechatSession:{
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.text images:kGetImage(self.image) url:[NSURL URLWithString:self.urlString]  title:self.title type:SSDKContentTypeAuto];
            [self shareParams:SSDKPlatformSubTypeWechatSession parameters:shareParams];
        }
            break;
        case SHShareModelTypeWechatTimeline:{
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.text images:kGetImage(self.image) url:[NSURL URLWithString:self.urlString]  title:self.title type:SSDKContentTypeAuto];
            [self shareParams:SSDKPlatformSubTypeWechatTimeline parameters:shareParams];
        }
            break;
        default:
            break;
    }
    SHWeakObj(self);
    [UIView animateWithDuration:0.5 animations:^{
        [weakself removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)shareWeiBoParams:(NSMutableDictionary*)shareParams{
    __block BOOL isWeiBoShare = YES;
    [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        isWeiBoShare = NO;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isWeiBoShare" object:self userInfo:@{@"isWeiBoShare": @(isWeiBoShare)}];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isWeiBoShare" object:self userInfo:@{@"isWeiBoShare": @(isWeiBoShare)}];
}

- (void)shareParams:(int)shareType parameters:(NSMutableDictionary*)shareParams{
    [ShareSDK share:shareType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:{
                 AlertView* view = [[AlertView alloc] initTitle:@"分享成功"];
                 [self addSubview:view];
                 if (self.newsModel) {
                     [HttpRequest postScoreTotal:UserScoreTypeShare newsModel:self.newsModel];
                 }
             }
                 break;
             case SSDKResponseStateFail:{
                 AlertView* view = [[AlertView alloc] initTitle:@"分享失败"];
                 [self addSubview:view];
             }
                 break;
             case SSDKResponseStateCancel:{
                 AlertView* view = [[AlertView alloc] initTitle:@"分享取消"];
                 [self addSubview:view];
             }
                 break;
             default:
                 break;
         }
     }];
}

- (void)pushAlertViewController:(NSString*)title{
//    NSArray* array = @[@"确定"];
//    AlertViewController* alertCon = [AlertViewController initAlertControllerWithTitle:title massege:nil style:UIAlertControllerStyleAlert actionTitleArr:array alertAction:^(UIAlertAction * _Nonnull action) {
//        
//    } logoImageString:nil];
//    [alertCon showAlertController];
}

- (void)canceButtonClick{
    [self removeFromSuperview];
}

- (void)tapGesture{
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
