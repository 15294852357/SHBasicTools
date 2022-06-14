//
//  SHMenuInfoModel.m
//  WisdomPeoples
//
//  Created by 慧 on 2022/5/5.
//

#import "SHMenuInfoModel.h"

#pragma mark    上传图片
@implementation SHUploadImageInfoModel
+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{
        @"imageid" : @"id"
    };
}
@end


@implementation SHMenuModel
+ (NSDictionary*)mj_objectClassInArray{
    return @{
        @"data" : [SHMenuModel class]
    };
}
@end

@implementation SHMenuInfoModel

@end
