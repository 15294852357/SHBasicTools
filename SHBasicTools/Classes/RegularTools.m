//
//  RegularTools.m
//
//  Created by gorson on 4/7/15.
//

#import "RegularTools.h"

@implementation RegularTools

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
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 *  手机号码验证
 *
 *  @param mobile 手机号码字符串
 *
 *  @return 是否手机号
 *
 *  (13[0-9]) 13开头
 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1(3|4|5|6|7|8|9)\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];

}

//是否是纯数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

/**
 *  车牌号验证
 *
 *  @param carNo 车牌号码字符串
 *
 *  @return 是否车牌号
 *
 *  [\u4e00-\u9fa5] 是否中文字
 */
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

/**
 *  车型验证
 *
 *  @param CarType 车型字符串
 *
 *  @return 是否车型
 *
 *  [\u4E00-\u9FFF] 是否中文字
 */
//
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

/**
 *  用户名验证
 *
 *  @param name 用户名字符串
 *
 *  @return 是否用户名
 *  {6,20}  6到20位
 */
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

/**
 *  密码认证
 *  以字母开头，密码必须含有字母和数字
 *  @param passWord 密码字符串
 *
 *  @return 是否密码
 *  {5,19}  6到20位
 */
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


/**
 *  验证认证
 *
 *  @param verifyCode 密码字符串
 *
 *  @return 是否密码
 *  {6,20}  6到20位
 */
+ (BOOL) validateVerify:(NSString *)verifyCode
{
    NSString *passWordRegex = @"^[0-9]{4}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:verifyCode];
}

/**
 *  验证昵称
 *
 *  @param nickname 昵称字符串
 *
 *  @return 是否昵称
 *  {4,8}  4到8位
 */
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{0,16}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

/**
 *  身份证号
 *
 *  @param identityCard 身份证号字符串
 *
 *  @return 是否身份证号
 *  d{14} 14位数字
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//验证日期格式
+ (BOOL) date: (NSString *)date{
    BOOL flag;
    if (date.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3}).(((0[13578]|1[02]).(0[1-9]|[12][0-9]|3[01]))|((0[469]|11).(0[1-9]|[12][0-9]|30))|(02.(0[1-9]|[1][0-9]|2[0-8])))$";
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [datePredicate evaluateWithObject:date];
}
//验证IP地址
+ (BOOL)isIpAddress:(NSString*)ipString{
    BOOL flag;
    if (ipString.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [datePredicate evaluateWithObject:ipString];
}


/// 纳税识别号
+ (BOOL)isTaxNumber:(NSString*)string{
    NSString *regex = @"[0-9A-HJ-NPQRTUWXY]{2}\\d{6}[0-9A-HJ-NPQRTUWXY]{10}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:string];
}

//验证是否包含特殊字符
+ (BOOL)hasIllegalCharacter:(NSString *)content {
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
// 判断是否是银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

@end
