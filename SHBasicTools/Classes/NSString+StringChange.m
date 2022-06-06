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
/// 将字符串转化为控制器
+ (UIViewController*)stringChangeToClass:(NSString *)str {
    id vc = [[NSClassFromString(str) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}
/// Base64
+ (NSString*)getBase64String{
    NSInteger before = arc4random() % 9 + 100000000;
    NSInteger after = arc4random() % 9 + 100000000;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString* timeString = [NSString stringWithFormat:@"%.0f",now];
    timeString = [timeString substringToIndex:10];
    now = [timeString intValue];

    NSString* beforeString = [NSString stringWithFormat:@"%ld",(long)before];
    NSString* afterString = [NSString stringWithFormat:@"%ld",(long)after];
    NSString* nowString = [NSString stringWithFormat:@"%.0f",now];

    NSString* base64String = [NSString stringWithFormat:@"%@%@%@",beforeString,nowString,afterString];
    NSData* data = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

@end
