//
//  RegularTools.h
//
//  Created by gorson on 4/7/15.
//

#import <Foundation/Foundation.h>

@interface RegularTools : NSObject

/**
 *  验证邮箱
 *
 *  @param email 邮箱字符串
 *
 *  @return 是否邮箱
 *
 *  [A-Z0-9a-z] 表示 A-Z 与 0-9 与 a-z 任意一个
 *  {2,4}       表示 字符位大于2个，小于4个
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  手机号码验证
 *
 *  @param mobile 手机号码字符串
 *
 *  @return 是否手机号
 *
 *  (13[0-9]) 13开头
 */
+ (BOOL) validateMobile:(NSString *)mobile;

//是否是纯数字
+ (BOOL)isNum:(NSString *)checkedNumString;
//  车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//  车型验证
+ (BOOL) validateCarType:(NSString *)CarType;

/**
 *  用户名验证
 *
 *  @param name 用户名字符串
 *
 *  @return 是否用户名
 *  {6,20}  6到20位
 */
+ (BOOL) validateUserName:(NSString *)name;

/**
 *  验证昵称
 *
 *  @param nickname 昵称字符串
 *
 *  @return 是否昵称
 *  {4,8}  4到8位
 */
+ (BOOL) validateNickname:(NSString *)nickname;

/**
 *  密码认证
 *  {6,20}  6到20位
 */
+ (BOOL) validatePassword:(NSString *)passWord;

//  身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  验证认证
 *
 *  @param verifyCode 密码字符串
 *
 *  @return 是否密码
 *  {6,20}  6到20位
 */
+ (BOOL) validateVerify:(NSString *)verifyCode;

// 判断银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo;
/// 纳税识别号
+ (BOOL)isTaxNumber:(NSString*)string;

+ (BOOL)hasIllegalCharacter:(NSString *)content;
@end
