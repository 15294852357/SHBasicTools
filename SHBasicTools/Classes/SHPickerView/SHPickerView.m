//
//  SHPickerView.m
//  WisdomPeoples
//
//  Created by 慧 on 2021/1/15.
//  Copyright © 2021 慧. All rights reserved.
//

#import "SHPickerView.h"

#define  KFont   [UIFont boldSystemFontOfSize:CONVER_VALUE(14.0f)]

@interface SHPickerView ()
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *completeBtn;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,assign) NSInteger selectIndex;
@property(nonatomic,assign) NSInteger selectSecondIndex;
@property(nonatomic,assign) NSInteger selectThirdIndex;

@end

@implementation SHPickerView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.datePickerMode = PGDatePickerModeDate;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.frame = [UIScreen mainScreen].bounds;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, keySCREEN_WIDTH, CONVER_VALUE(300.0f))];
    [self addSubview:_bgView];
    _bgView.tag = 100;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self showAnimation];
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(CONVER_VALUE(15.0f));
        make.width.height.mas_equalTo(CONVER_VALUE(44.0f));
    }];
    self.cancelBtn.titleLabel.font = KFont;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:UIColorFromRGBAlpha(0x999999, 1) forState:UIControlStateNormal];
    //完成
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CONVER_VALUE(- 15.0f));
        make.width.height.top.mas_equalTo(self.cancelBtn);
    }];
    self.completeBtn.titleLabel.font = KFont;
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completeBtn setTitleColor:Main_Color forState:UIControlStateNormal];
    
    SHWeakObj(self);
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = black_Color;
    self.titleLab.font = KFont;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.completeBtn.mas_centerY);
    }];

    self.line = [[UIView alloc]init];
    [self.bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelBtn.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(keySCREEN_WIDTH);
        make.height.mas_equalTo(CONVER_VALUE(0.5f));
    }];
    self.line.backgroundColor = line_Color;
}
#pragma mark pickerViewType
- (void)setPickerViewType:(SHPickerViewType)pickerViewType{
    _pickerViewType = pickerViewType;
    switch (pickerViewType) {
        case SHPickerViewTypeSex:{
            if ([[NSString StringConverWithString:self.titleString] isEqualToString:@""]) {
                self.titleString = @"选择性别";
            }
            self.titleLab.text = self.titleString;
            [self isDataPicker:NO];
        }
            break;
        case SHPickerViewTypeArea:{
            self.titleLab.text = @"选择地区";
            [self isDataPicker:NO];
        }
            break;
        case SHPickerViewTypeIndustryCategory:{
            self.titleLab.text = @"选择行业类别";
            [self isDataPicker:NO];
        }
            break;
        case SHPickerViewTypeDate:{
            if ([[NSString StringConverWithString:self.titleString] isEqualToString:@""]) {
                self.titleString = @"选择时间";
            }
            self.datePickManager.titleLabel.text = self.titleString;
            self.datePicker.datePickerMode = self.datePickerMode;
            [self isDataPicker:YES];
        }
            break;
        default:
            break;
    }
}

- (void)isDataPicker:(BOOL)isData{
    SHWeakObj(self);
    if (isData) {
        [self hideAnimation];

        UIWindow* window = [UIApplication sharedApplication].delegate.window;
        UITabBarController *tbc = (UITabBarController *)window.rootViewController;
        UINavigationController *nc = tbc.selectedViewController;
        UIViewController *vc = nc.visibleViewController;
        [vc presentViewController:self.datePickManager animated:NO completion:nil];
    }else{
        [_bgView addSubview:self.picker];
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakself.line.mas_bottom);
            make.bottom.left.right.mas_equalTo(0);
        }];
    }
}
#pragma mark    选择行列
- (void)setSelectComponent:(NSInteger)selectComponent{
    _selectComponent = selectComponent;
     [self.picker selectRow:selectComponent inComponent:0 animated:NO];
}
#pragma mark 取消
- (void)cancelBtnClick{
    [self hideAnimation];
    
    SHPickerModel* selectModel = nil;
    if (self.pickerViewResultBlock) {
        self.pickerViewResultBlock(self, @"", selectModel);
    }
}
#pragma mark 确定
-(void)completeBtnClick{
    [self hideAnimation];
     NSString *resultStr = [NSString string];
    SHPickerModel* selectModel = nil;
    if (self.pickerViewType == SHPickerViewTypeSex) {
        //性别
        SHPickerModel* model = self.dataArray[self.selectIndex];
        if (![[NSString StringConverWithString:model.dictLabel] isEqualToString:@""]) {
            resultStr = model.dictLabel;
        }
        selectModel = model;
    }else if (self.pickerViewType == SHPickerViewTypeArea){
        //地区
        SHPickerModel* model = self.dataArray[self.selectIndex];
        resultStr = [resultStr stringByAppendingFormat:@"%@-",model.name];
        
        SHPickerModel* seconModel = model.childrens[self.selectSecondIndex];
        resultStr = [resultStr stringByAppendingFormat:@"%@-",seconModel.name];
        
        SHPickerModel* thridModel = seconModel.childrens[self.selectThirdIndex];
        resultStr = [resultStr stringByAppendingString:thridModel.name];
    }else if (self.pickerViewType == SHPickerViewTypeIndustryCategory){
        //行业分类
        SHPickerModel* model = self.dataArray[self.selectIndex];
//        resultStr = [resultStr stringByAppendingFormat:@"%@-",model.categoryName];
        
        SHPickerModel* seconModel = model.childrens[self.selectSecondIndex];
        resultStr = [resultStr stringByAppendingString:seconModel.categoryName];
        
        selectModel = seconModel;
    }
    if (self.pickerViewResultBlock) {
        self.pickerViewResultBlock(self, resultStr, selectModel);
    }
}
#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    switch (self.pickerViewType) {
        case SHPickerViewTypeSex:{
            return 1;
        }
            break;
        case SHPickerViewTypeIndustryCategory:{
            return 2;
        }
            break;
        case SHPickerViewTypeArea:{
            return 3;
        }
            break;
        default:
            break;
    }
    return 0;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (self.pickerViewType) {
        case SHPickerViewTypeSex:{
            return self.dataArray.count;
        }
            break;
        case SHPickerViewTypeIndustryCategory:{
            if (component == 0) {
                return self.dataArray.count;
            }else{
                SHPickerModel* model = self.dataArray[self.selectIndex];
                return model.childrens.count;
            }
        }
            break;
        case SHPickerViewTypeArea:{
            SHPickerModel* model = self.dataArray[self.selectIndex];

            if (component == 0) {
                return self.dataArray.count;
            }else if (component == 1){
                return model.childrens.count;
            }else{
                SHPickerModel* seconModel = model.childrens[self.selectSecondIndex];
                return seconModel.childrens.count;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel *label = [[UILabel alloc] init];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    return label;
//}
//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (self.pickerViewType) {
        case SHPickerViewTypeSex:{
            SHPickerModel* model = self.dataArray[row];
            NSString* string = @"";
            if (![[NSString StringConverWithString:model.dictLabel] isEqualToString:@""]) {
                string = [NSString StringConverWithString:model.dictLabel];
            }
            return string;
        }
            break;
        case SHPickerViewTypeIndustryCategory:{
            if (component == 0) {
                SHPickerModel* model = self.dataArray[row];
                return [NSString StringConverWithString:model.categoryName];
            }else{
                SHPickerModel* model = self.dataArray[self.selectIndex];
                SHPickerModel* subModel = model.childrens[row];
                return [NSString StringConverWithString:subModel.categoryName];
            }
        }
            break;
        case SHPickerViewTypeArea:{
            if (component == 0) {
                SHPickerModel* model = self.dataArray[row];
                return [NSString StringConverWithString:model.name];
            }else if (component == 1){
                SHPickerModel* model = self.dataArray[self.selectIndex];
                SHPickerModel* seconModel = model.childrens[row];
                return [NSString StringConverWithString:seconModel.name];
            }else{
                SHPickerModel* model = self.dataArray[self.selectIndex];
                SHPickerModel* seconModel = model.childrens[self.selectSecondIndex];
                SHPickerModel* thridModel = seconModel.childrens[row];
                return [NSString StringConverWithString:thridModel.name];
            }
        }
            break;
        default:
            break;
    }
    return nil;    
}
//选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        if (self.pickerViewType == SHPickerViewTypeIndustryCategory || self.pickerViewType == SHPickerViewTypeArea) {
            self.selectIndex = [pickerView selectedRowInComponent:0];
             [pickerView reloadComponent:1];
        }
        if (self.pickerViewType == SHPickerViewTypeSex) {
            self.selectIndex = [pickerView selectedRowInComponent:0];
        }
    }else if (component == 1){
        if (self.pickerViewType == SHPickerViewTypeArea) {
            self.selectSecondIndex = [pickerView selectedRowInComponent:1];
             [pickerView reloadComponent:2];
        }
        if (self.pickerViewType == SHPickerViewTypeIndustryCategory) {
            self.selectSecondIndex = [pickerView selectedRowInComponent:1];
        }
    }else{
        self.selectThirdIndex = [pickerView selectedRowInComponent:2];
    }
}
//列宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return keySCREEN_WIDTH;
    }else if (component == 1){
        return keySCREEN_WIDTH / 2;
    }else{
        return keySCREEN_WIDTH / 3;
    }
}
//防止崩溃
- (NSUInteger)indexOfNSArray:(NSArray *)arr WithStr:(NSString *)str{
    NSUInteger chosenDxInt = 0;
    if (str && ![str isEqualToString:@""]) {
        chosenDxInt = [arr indexOfObject:str];
        if (chosenDxInt == NSNotFound)
            chosenDxInt = 0;
    }
    return chosenDxInt;
}
#pragma mark tool
//处理省份和城市名相同
- (NSString *)handleCityWithCity:(NSString *)result{
  NSArray *cityAry = [result componentsSeparatedByString:@"-"];
    if ([cityAry[0] isEqualToString:cityAry[1]]) {
        return cityAry[0];
    }else{
        return result;
    }
}
#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch.view.tag !=100) {
        [self hideAnimation];
    }
}

- (void)showAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height-CONVER_VALUE(300.0f);
        self.bgView.frame = frame;
    }];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height;
        self.bgView.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (PGDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = self.datePickManager.datePicker;
        //设置线条的颜色
        _datePicker.lineBackgroundColor = bg_Color;
        _datePicker.rowHeight = 35;
        //    _datePicker.minimumDate = [NSDate date];
        //    _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60 * 365 * 10];
        //设置选中行的字体颜色
        _datePicker.textColorOfSelectedRow = UIColorFromRGBAlpha(0x18aaf6, 1);
        //设置未选中行的字体颜色
        _datePicker.textColorOfOtherRow = UIColorFromRGBAlpha(0x999999, 1);
    }
    return _datePicker;
}

- (PGDatePickManager *)datePickManager{
    if (!_datePickManager) {
        _datePickManager = [[PGDatePickManager alloc]init];
        //设置头部的背景颜色
        _datePickManager.headerViewBackgroundColor = [UIColor whiteColor];
        //设置取消按钮的字体颜色
        _datePickManager.cancelButtonTextColor = UIColorFromRGBAlpha(0x999999, 1);
        //设置取消按钮的字
        _datePickManager.cancelButtonText = @"取消";
        //设置取消按钮的字体大小
        _datePickManager.cancelButtonFont = KFont;
        //设置确定按钮的字体颜色
        _datePickManager.confirmButtonTextColor = Main_Color;
        //设置确定按钮的字
        _datePickManager.confirmButtonText = @"确定";
        //设置确定按钮的字体大小
        _datePickManager.confirmButtonFont = KFont;
    }
    return _datePickManager;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
