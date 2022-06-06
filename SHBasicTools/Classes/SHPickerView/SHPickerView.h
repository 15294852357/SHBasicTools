//
//  SHPickerView.h
//  WisdomPeoples
//
//  Created by 慧 on 2021/1/15.
//  Copyright © 2021 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHPickerModel;
@class SHPickerView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SHPickerViewType) {
    //列数也是如此
    /// 性别
    SHPickerViewTypeSex = 1,
    /// 行业分类
    SHPickerViewTypeIndustryCategory = 2,
    /// 地区
    SHPickerViewTypeArea = 3,
    /// 年月日
    SHPickerViewTypeDate = 4,
};

typedef void(^SHPickerViewResult)(SHPickerView* pickerView,NSString* resultString,SHPickerModel* model);

@interface SHPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) NSString *titleString;

@property(nonatomic,strong) UIPickerView *picker;
@property (nonatomic,strong) PGDatePickManager* datePickManager;
@property (nonatomic,strong) PGDatePicker *datePicker;
@property (nonatomic, assign) PGDatePickerMode datePickerMode; // default is PGDatePickerModeDate
@property(nonatomic,assign) SHPickerViewType pickerViewType;
@property(nonatomic,strong) NSMutableArray *dataArray;
//默认选中第一列
@property (nonatomic,assign)NSInteger selectComponent;

@property (nonatomic,copy) SHPickerViewResult pickerViewResultBlock;
@end

NS_ASSUME_NONNULL_END
