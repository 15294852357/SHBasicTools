//
//  SHShareInfoModel.h
//  WisdomPeoples
//
//  Created by 慧 on 2022/3/30.
//  Copyright © 2022 慧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SHShareModelType) {
    /// 微信好友
    SHShareModelTypeWechatSession = 1,
    /// 微信朋友圈
    SHShareModelTypeWechatTimeline,
    /// QQ好友
    SHShareModelTypeQQFriend,
    /// QQ空间
    SHShareModelTypeQZone,
    /// 微博
    SHShareModelTypeWeibo,
    /// 拷贝
    SHShareModelTypeCopy,
    /// 投诉
    SHShareModelTypeComplaints,
};

@interface SHShareModel : NSObject
@property (nonatomic, strong) NSString * shareId;
@property (nonatomic, strong) NSString * shareIcon;
@property (nonatomic, strong) NSString * shareName;

@property (nonatomic, assign) SHShareModelType shareType;
@end

@interface SHShareInfoModel : NSObject
@property (nonatomic,strong) NSArray* data;
@end

NS_ASSUME_NONNULL_END
