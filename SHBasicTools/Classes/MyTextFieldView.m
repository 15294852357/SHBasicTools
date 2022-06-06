//
//  MyTextField.m
//  TextFiled
//
//  Created by 慧 on 2020/4/14.
//  Copyright © 2020 慧. All rights reserved.
//

#import "MyTextFieldView.h"

@implementation MyTextField

//删除键
- (void)deleteBackward{
    [super deleteBackward];
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(MyTextFieldDelegate:)]) {
        [self.myDelegate MyTextFieldDelegate:self];
    }
}

- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

@end

@implementation MyTextFieldView

- (instancetype)initMyTextFieldViewWithCount:(NSInteger)count space:(CGFloat)space width:(CGFloat)width{
    self = [super init];
    if (self) {
        _textFieldArray = [NSMutableArray array];
        _textFieldTextStringArray = [NSMutableArray array];
            
        CGFloat textWidth = (width - space * count) / count;
        for (int i = 0; i < count; i ++) {
            [_textFieldTextStringArray addObject:@""];
            
            MyTextField* textFile = [[MyTextField alloc]init];
            textFile.frame = CGRectMake(i * (space + textWidth), 0, textWidth, 44);
            [textFile addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
            textFile.tag = i;
            textFile.textAlignment = NSTextAlignmentCenter;
            textFile.myDelegate = self;
            textFile.delegate = self;
            [self addSubview:textFile];
            [_textFieldArray addObject:textFile];
            if (i == 0) {
                [textFile becomeFirstResponder];
            }
        }
    }
    return self;
}

- (void)MyTextFieldDelegate:(MyTextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        UITextField* nextTextFiled;
        if (textField.tag == 0) {
            nextTextFiled = _textFieldArray[0];
        }else{
            nextTextFiled = _textFieldArray[textField.tag - 1];
        }
        [nextTextFiled becomeFirstResponder];
        [_textFieldTextStringArray replaceObjectAtIndex:textField.tag withObject:@""];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location > 0) {
        UITextField* nextTextFiled;
        if (textField.tag == _textFieldArray.count - 1) {
            nextTextFiled = _textFieldArray[_textFieldArray.count - 1];
        }else{
            nextTextFiled = _textFieldArray[textField.tag + 1];
        }
        [nextTextFiled becomeFirstResponder];

        return NO;
    }
    return YES;
}

- (void)textFiled:(MyTextField*)textField{
    if (textField.text.length == 1) {
        UITextField* text;
        for (int i = 0; i < _textFieldArray.count; i ++) {
            if (textField.tag == i) {
                text = textField;
            }
        }
        [self textFieldBecomeFirstResponder:text];
    }
}

- (void)textFieldBecomeFirstResponder:(UITextField*)CurrentTextField{
    if (CurrentTextField.text.length == 0) {
        [_textFieldTextStringArray replaceObjectAtIndex:CurrentTextField.tag withObject:CurrentTextField.text];

        UITextField* nextTextFiled;
        if (CurrentTextField.tag == 0) {
            nextTextFiled = _textFieldArray[0];
        }else{
            nextTextFiled = _textFieldArray[CurrentTextField.tag - 1];
        }
        [nextTextFiled becomeFirstResponder];
    }else{
        [_textFieldTextStringArray replaceObjectAtIndex:CurrentTextField.tag withObject:CurrentTextField.text];
        [CurrentTextField resignFirstResponder];

        UITextField* nextTextFiled;
        if (CurrentTextField.tag == _textFieldArray.count - 1) {
            nextTextFiled = _textFieldArray[_textFieldArray.count - 1];
        }else{
            nextTextFiled = _textFieldArray[CurrentTextField.tag + 1];
        }
        [nextTextFiled becomeFirstResponder];
    }
    for (NSString* string in _textFieldTextStringArray) {
        if ([[NSString StringConverWithString:string] isEqualToString:@""]) {
            return;
        }
    }
    [self endEditing:YES];
    if (self.myTextFieldViewResultArray) {
        self.myTextFieldViewResultArray(_textFieldTextStringArray);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
