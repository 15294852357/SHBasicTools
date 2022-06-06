//
//  AlertView.h
//  WisdomPeoples
//
//  Created by 慧 on 2018/12/21.
//  Copyright © 2018年 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView

@property (nonatomic , strong)UIView *bgView;

@property (nonatomic,strong)UILabel * label1;

@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)UIButton *cancleBtn;


//长方形提示框
- (instancetype)initTitle:(NSString *)title;

- (instancetype)initTitle:(NSString *)title AndContent:(NSString *)content AndSureBtn:(NSString *)sureStr;

- (instancetype)initContent:(NSString *)content AndSureBtn:(NSString *)sureStr AndCancleStr:(NSString *)cancleStr;

- (instancetype)initBlackViewAndContent:(NSString *)content AndtTitle:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
