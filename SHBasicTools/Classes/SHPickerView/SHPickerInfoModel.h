//
//  SHPickerInfoModel.h
//  WisdomPeoples
//
//  Created by 慧 on 2021/1/15.
//  Copyright © 2021 慧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHPickerModel : NSObject
//用户类型  性别  需求类型    服务类型     
@property (nonatomic, strong) NSString * dictLabel;
@property (nonatomic, strong) NSString * dictValue;

//省市区
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * areaType;
@property (nonatomic, strong) NSString * topCode;
@property (nonatomic, strong) NSArray * childrens;

//行业分类
@property (nonatomic, strong) NSString * categoryId;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * categorySort;
@property (nonatomic, strong) NSString * categoryType;
@property (nonatomic, strong) NSString * parentId;
//@property (nonatomic, strong) NSArray * childrens;
@end

@interface SHPickerInfoModel : NSObject

@end

NS_ASSUME_NONNULL_END
