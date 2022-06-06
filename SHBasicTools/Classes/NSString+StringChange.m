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

+ (CGFloat)getWidthWithContent:(NSString *)content andHeight:(CGFloat)height andFontSize:(int)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

+ (CGFloat)getHeightWithContent:(NSString *)content andWidth:(CGFloat)width andFontSize:(int)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.height;
}

+ (void)setAccessoryView:(UITableViewCell*)cell imageName:(NSString*)imageName{
    if ([imageName isEqualToString:@""]) {
        cell.accessoryView = nil;
        return;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
//    CGFloat imageHeight= CONVER_VALUE(14.0f);
//    imageView.frame=CGRectMake(0, 0, imageHeight, imageHeight * image.size.height / image.size.width);
    imageView.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    cell.accessoryView = imageView;
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
#pragma mark   ---------- 时间
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
/// 年月日
+ (NSString*)getTimeWithYearMonthDay:(NSString*)timeString{
    NSInteger day = [timeString integerValue] / 60 / 24;
    NSInteger hours = ([timeString integerValue] - day * 24 * 60) / 60 ;
    NSInteger minutes = [timeString integerValue] % 60;
    NSMutableString* string = [NSMutableString string];
    if (day > 0) {
        [string appendFormat:@"%ld天",(long)day];
    }
    if (hours > 0) {
        [string appendFormat:@"%ld小时",(long)hours];
    }
    if (minutes > 0) {
        [string appendFormat:@"%ld分钟",(long)minutes];
    }
    return [string copy];
}
/// 根据起始时间和时间间隔计算时间
/// @param timeSpace  时间间隔 以分钟为单位
/// @param startDateString 开始时间
+ (NSString*)getEndDate:(NSString*)timeSpace startDateString:(NSString*)startDateString{
    //获取NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    //进行转化
    NSDate * startDate = [dateFormatter dateFromString:startDateString];

    NSDate *resultDate = [NSDate dateWithTimeInterval:60 * ([timeSpace integerValue]) sinceDate:startDate];

//    NSDate * resultDate = [self getResultDate:startDate timeInterval:[timeSpace integerValue]];
    //将结果时间转化成字符串
    NSString *resulttime = [dateFormatter stringFromDate: resultDate];
    return resulttime;
}
/// 比较两个时间相差多少小时
/// @param startDate 开始时间
/// @param endDate 结束时间
/// @param secondsOrHour 除以3600是把秒化成小时，除以60得到结果为相差的分钟数
+ (NSInteger)getTimeIntervalWithStartDate:(NSDate*)startDate endDate:(NSDate*)endDate secondsOrHour:(NSInteger)secondsOrHour{
    NSTimeInterval timeInterval = [startDate timeIntervalSinceDate:endDate];
    NSInteger interval = timeInterval / secondsOrHour;
    return interval;
}

/// 将时间戳转换成时间
+ (NSString *)getTimeFromTimestamp:(NSString*)time dateFormatString:(NSString*)dateFormatString{
    if ([[self StringConverWithString:dateFormatString] isEqualToString:@""]) {
        dateFormatString = @"YYYY-MM-dd HH:mm:ss";
    }
    NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormatString];
    NSString *timeStr = [formatter stringFromDate:myDate];
    return timeStr;
}
#pragma mark   ---------- 移除最后的符号
/// 移除最后的符号
/// @param string 内容
/// @param symbolString 符号
+ (NSString*)getStringRemoveSpace:(NSString*)string symbolString:(NSString*)symbolString{
    NSArray* array = [NSArray array];
    if (![[NSString StringConverWithString:string] isEqualToString:@""]) {
        array = [string componentsSeparatedByString:symbolString];
    }
    NSMutableArray* mutaArray = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < mutaArray.count; i ++) {
        NSString* string = mutaArray[i];
        if ([[NSString StringConverWithString:string] isEqualToString:@""]) {
            [mutaArray removeObject:string];
        }
    }
    array = [mutaArray copy];
    string = [array componentsJoinedByString:symbolString];
    return string;
}
#pragma mark   ---------- 汉字转拼音
//获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    for (int i = 0; i < pinyinArray.count; i++){
        for(int i = 0; i < pinyinArray.count;i++){
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    for (NSString *s in pinyinArray){
        if (s.length > 0){
            [initialStr appendString:[s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    return allString;
}
/// 汉字转拼音
+ (NSString *)transform:(NSString *)chinese{
    if(!chinese){
        return nil;
    }
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}
/// 拿到第一个字母并排序
+ (NSString *)getFirstUpperLetter:(NSString *)chinese {
    NSString *pinyin = [self transform:chinese];
    NSString *firstUpperLetter = [[pinyin substringToIndex:1] uppercaseString];
    if ([firstUpperLetter compare:@"A"] != NSOrderedAscending &&
        [firstUpperLetter compare:@"Z"] != NSOrderedDescending) {
        return firstUpperLetter;
    } else {
        return @"#";
    }
}
+ (NSMutableDictionary *)sortArrayWithPinYin:(NSArray *)list{
    NSMutableArray *contentArray = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        [contentArray addObject:[NSMutableArray array]];
    }
    NSArray *keys = @[
                      @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N",
                      @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"
                      ];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (id user in list) {
        NSString *firstLetter;
        firstLetter = [self getFirstUpperLetter:(NSString *)user];
        int asciiIndex = [firstLetter characterAtIndex:0];
        int index = asciiIndex - [@"A" characterAtIndex:0];
        char c = [firstLetter characterAtIndex:0];
        if (isalpha(c) == 0) {
            [tempArray addObject:user];
        }else{
            NSMutableArray *indexArray = [contentArray objectAtIndex:index];
            [indexArray addObject:user];
        }
    }
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    for(int i = 0; i < contentArray.count; i++){
        NSMutableArray *itemArray = [contentArray objectAtIndex:i];
        if(itemArray.count > 0){
            
            if (![itemArray count])
                continue;
            [infoDic setObject:itemArray forKey:keys[i]];
        }
    }
    if ([tempArray count]) [infoDic setObject:tempArray forKey:@"#"];
    
    NSArray *key = [[infoDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *allKeys = [[NSMutableArray alloc] initWithArray:key];
    NSMutableDictionary *resultDic = [NSMutableDictionary new];
    [resultDic setObject:infoDic forKey:@"infoDic"];
    [resultDic setObject:allKeys forKey:@"allKeys"];
    return resultDic;
}

+ (NSString *)getNumberFromStr:(NSString *)str{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}
/// 字典转json字符串
+ (NSString *)convertToJsonStringWithDictionay:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"error--- %@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}
/// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {/*JSON解析失败*/
        return nil;
    }
    return dic;
}

@end
