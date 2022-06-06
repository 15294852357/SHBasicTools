//
//  MyTextField.h
//  TextFiled
//
//  Created by 慧 on 2020/4/14.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyTextField;
@protocol MyTextFieldDelegate <NSObject>

- (void)MyTextFieldDelegate:(MyTextField*)textField;
@end

@interface MyTextField : UITextField
/// 自定义tag值
@property (nonatomic,strong) NSIndexPath* indexPath;

@property (nonatomic,weak) id<MyTextFieldDelegate> myDelegate;
@property (nonatomic,assign) CGFloat textLength;

/// 设置某边边框
- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end



typedef void(^ReturnTextStringArray)(NSMutableArray* array);

@interface MyTextFieldView : UIView<MyTextFieldDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray* textFieldArray;
@property (nonatomic,strong) NSMutableArray* textFieldTextStringArray;

@property (nonatomic,copy) ReturnTextStringArray myTextFieldViewResultArray;

- (instancetype)initMyTextFieldViewWithCount:(NSInteger)count space:(CGFloat)space width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
