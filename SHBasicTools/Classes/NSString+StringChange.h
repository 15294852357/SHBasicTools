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

+ (CGFloat)getWidthWithContent:(nullable NSString *)content andHeight:(CGFloat)height andFontSize:(int)font;
+ (CGFloat)getHeightWithContent:(nullable NSString *)content andWidth:(CGFloat)width andFontSize:(int)font;

/// 设置cellAccessoryView
+ (void)setAccessoryView:(nullable UITableViewCell*)cell imageName:(nullable NSString*)imageName;

/// 将字符串转化为控制器
/// @param str 需要转化的字符串
+ (UIViewController*_Nullable)stringChangeToClass:(NSString *_Nonnull)str;

/// Base64
+ (NSString*_Nonnull)getBase64String;
#pragma mark   ---------- 时间
/// 年月日
/// @param string 时间
+ (NSString* _Nullable)getTimeWithYearMonthDay:(nullable NSString*)string;
/// 时间化时间戳
+ (NSString *_Nullable)getTimeNow:(nullable NSString*)dateFormatString;

/// 根据起始时间和时间间隔计算时间
/// @param timeSpace  时间间隔 以分钟为单位
/// @param startDateString 开始时间
+ (NSString* _Nullable)getEndDate:(NSString*_Nullable)timeSpace startDateString:(NSString* _Nullable)startDateString;

/// 比较两个时间相差多少小时
/// @param startDate 开始时间
/// @param endDate 结束时间
/// @param secondsOrHour 除以3600是把秒化成小时，除以60得到结果为相差的分钟数
+ (NSInteger)getTimeIntervalWithStartDate:(NSDate*_Nullable)startDate endDate:(NSDate*_Nullable)endDate secondsOrHour:(NSInteger)secondsOrHour;

/// 将时间戳转换成时间
+ (NSString *_Nullable)getTimeFromTimestamp:(NSString*_Nullable)time dateFormatString:(nullable NSString*)dateFormatString;
#pragma mark   ---------- 移除最后的符号
/// 移除最后的符号
/// @param string 内容
/// @param symbolString 符号
+ (NSString* _Nullable)getStringRemoveSpace:(nullable NSString*)string symbolString:(nullable NSString*)symbolString;

#pragma mark   ---------- 汉字转拼音
+ (NSString *_Nullable)transformToPinyin:(nullable NSString *)aString;
/// 汉字转拼音
+ (NSString * _Nullable)transform:(nullable NSString *)chinese;
/// 拿到第一个字母并排序
+ (NSString *_Nullable)getFirstUpperLetter:(nullable NSString *)chinese;

+ (NSMutableDictionary *_Nullable)sortArrayWithPinYin:(nullable NSArray *)list;

+ (NSString *_Nullable)getNumberFromStr:(nullable NSString *)str;

/// 字典转json字符串
+ (NSString *_Nullable)convertToJsonStringWithDictionay:(nullable NSDictionary *)dict;
/// json字符串转字典
+ (NSDictionary *_Nullable)dictionaryWithJsonString:(nullable NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
