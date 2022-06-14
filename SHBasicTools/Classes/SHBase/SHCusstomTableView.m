//
//  SHCusstomTableView.m
//  JXAoBo
//
//  Created by 慧 on 2021/1/18.
//  Copyright © 2021 慧. All rights reserved.
//

#import "SHCusstomTableView.h"

@interface SHCusstomTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIScrollViewDelegate>
/// 缺省图片
@property (nonatomic,copy) NSString* imageName;
///标题
@property (nonatomic,copy) NSString* titleString;
/// 标题颜色
@property (nonatomic,copy) UIColor* titleColor;
/// 标题大小
@property (nonatomic,assign) CGFloat titleFont;

///描述
@property (nonatomic,copy) NSString* descriptionString;
/// 描述颜色
@property (nonatomic,copy) UIColor* descriptionColor;
/// 描述大小
@property (nonatomic,assign) CGFloat descriptionFont;

///按钮标题
@property (nonatomic,copy) NSString* buttonTitleString;
/// 按钮标题颜色
@property (nonatomic,copy) UIColor* buttonTitleColor;
/// 按钮标题大小
@property (nonatomic,assign) CGFloat buttonTitleFont;
@end

@implementation SHCusstomTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.emptyDataSetDelegate = self;
        self.emptyDataSetSource = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
#pragma mark    数据为空是否还可以下拉刷新
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
#pragma mark    空白页图片
- (UIImage*)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (!self.emptyImageName) {
        self.emptyImageName = @"defult_订单";
    }
    return kGetImage(self.emptyImageName);
}
#pragma mark    空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (!self.emptyTitleString) {
        self.emptyTitleString = @"暂无数据";
    }
    if (!self.emptyTitleColor) {
        self.emptyTitleColor = UIColorFromRGBAlpha(0xFDACA7, 1);
    }
    if (!self.emptyTitleFont) {
        self.emptyTitleFont = 16.0f;
    }
    NSString *title = self.emptyTitleString;
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:self.emptyTitleFont],
        NSForegroundColorAttributeName:self.emptyTitleColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
#pragma mark    空白页显示详细描述
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    if (!self.descriptionString) {
//        self.emptyDescriptionString = @"暂无数据，请稍后再试～";
//        self.emptyDescriptionColor = [UIColor lightGrayColor];
//        self.emptyDescriptionFont = 14.0f;
//    }
//    NSString *text = self.emptyDescriptionString;
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    NSDictionary *attributes = @{
//        NSFontAttributeName:[UIFont systemFontOfSize:self.emptyDescriptionFont],
//        NSForegroundColorAttributeName:self.emptyDescriptionColor,
//        NSParagraphStyleAttributeName:paragraph
//    };
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
#pragma mark    空白页显示按钮
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    if (!self.buttonTitleString) {
//        self.emptyButtonTitleString = @"重新加载";
//        self.emptyButtonTitleColor = [UIColor blueColor];
//        self.emptyButtonTitleFont = 17.0f;
//    }
//    NSString *buttonTitle = self.emptyButtonTitleString;
//    NSDictionary *attributes = @{
//        NSFontAttributeName:[UIFont boldSystemFontOfSize:self.emptyButtonTitleFont],
//        NSForegroundColorAttributeName:self.emptyButtonTitleColor,
//    };
//    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
//}
#pragma mark    控件间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.spaceHeight) {
        self.spaceHeight = - 10.0f;
    }
    return self.spaceHeight;
}
#pragma mark    垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return - 20.0f;
}
#pragma mark - DZNEmptyDataSetDelegate
#pragma mark    点击按钮
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.emptyReloadData) {
        self.emptyReloadData(scrollView, button);
    }
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.contentOffset = CGPointZero;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
