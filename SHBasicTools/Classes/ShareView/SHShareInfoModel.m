//
//  SHShareInfoModel.m
//  WisdomPeoples
//
//  Created by 慧 on 2022/3/30.
//  Copyright © 2022 慧. All rights reserved.
//

#import "SHShareInfoModel.h"

@implementation SHShareModel
- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues{
    switch ([self.shareId intValue]) {
        case 1:
            self.shareType = SHShareModelTypeWechatSession;
            break;
        case 2:
            self.shareType = SHShareModelTypeWechatTimeline;
            break;
        case 3:
            self.shareType = SHShareModelTypeQQFriend;
            break;
        case 4:
            self.shareType = SHShareModelTypeQZone;
            break;
        case 5:
            self.shareType = SHShareModelTypeWeibo;
            break;
        case 6:
            self.shareType = SHShareModelTypeCopy;
            break;
        case 7:
            self.shareType = SHShareModelTypeComplaints;
            break;

        default:
            break;
    }
}
@end

@implementation SHShareInfoModel
+ (NSDictionary*)mj_objectClassInArray{
    return @{
        @"data" : [SHShareModel class]
    };
}
@end
