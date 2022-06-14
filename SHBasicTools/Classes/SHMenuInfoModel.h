//
//  SHMenuInfoModel.h
//  WisdomPeoples
//
//  Created by 慧 on 2022/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark    上传图片
@interface SHUploadImageInfoModel : NSObject
/// 文件ID
@property (nonatomic, strong) NSString * imageid;
@property (nonatomic, strong) NSString * parentid;
/// 文件名称
@property (nonatomic, strong) NSString * filename;
/// 表名
@property (nonatomic, strong) NSString * tablename;
/// 文件路径
@property (nonatomic, strong) NSString * fileurl;
@end


@interface SHMenuModel : NSObject
@property (nonatomic, strong) NSString * dictLabel;
@property (nonatomic, strong) NSString * dictValue;
@end


@interface SHMenuInfoModel : NSObject
@property (nonatomic,strong) NSArray* data;
@end

NS_ASSUME_NONNULL_END
