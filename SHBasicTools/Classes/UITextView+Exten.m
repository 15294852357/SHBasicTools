//
//  UITextView+Exten.m
//  WisdomPeoples
//
//  Created by 慧 on 2021/1/26.
//  Copyright © 2021 慧. All rights reserved.
//

#import "UITextView+Exten.h"
#import <objc/runtime.h>

NSString const *indexpathKey = @"indexpathKey";

@implementation UITextView (Exten)
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &indexpathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &indexpathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
