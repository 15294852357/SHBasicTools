//
//  NSString+StringChange.m
//  SHBasicTools
//
//  Created by 慧 on 2022/5/31.
//

#import "NSString+StringChange.h"

@implementation NSString (StringChange)
/// 空
+ (NSString*)StringConverWithString:(NSString*)oldString{
    NSString* tempString = [NSString stringWithFormat:@"%@",oldString];
    NSString* newStrng = @"";
    if (tempString) {
//        if ([tempString isEqualToString:@"(null)"] || [tempString isKindOfClass:[NSNull class]] || [tempString isEqualToString:@""] || [tempString isEqualToString:@"<null>"] || [tempString isEqualToString:@"null"]) {
//            newStrng = @"";
//        }else{
//            newStrng = tempString;
//        }
        if ([tempString isEqualToString:@"(null)"] || [tempString isKindOfClass:[NSNull class]] || [tempString isEqualToString:@""] || [tempString isEqualToString:@"<null>"]) {
            newStrng = @"";
        }else{
            newStrng = tempString;
        }
    }
    return newStrng;
}
/// 时间化时间戳
+ (NSString *)getTimeNow:(NSString*)dateFormatString{
    if ([[self StringConverWithString:dateFormatString] isEqualToString:@""]) {
        dateFormatString = @"yyyyMMddHHmmss";
    }
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:dateFormatString];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    return timeNow;
}

@end
