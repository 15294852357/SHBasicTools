//
//  NSString+StringChange.h
//  SHBasicTools
//
//  Created by 慧 on 2022/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringChange)
/// 空
+ (NSString*_Nullable)StringConverWithString:(nullable NSString*)oldString;
/// 时间化时间戳
+ (NSString *_Nullable)getTimeNow:(nullable NSString*)dateFormatString;

@end

NS_ASSUME_NONNULL_END
