//
//  UITextField+Exten.m
//  WisdomPeoples
//
//  Created by 慧 on 2021/1/26.
//  Copyright © 2021 慧. All rights reserved.
//

#import "UITextField+Exten.h"

#import <objc/runtime.h>

NSString const *NSIndexPathKey = @"NSIndexPathKey";

@implementation UITextField (Exten)

- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &NSIndexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &NSIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
