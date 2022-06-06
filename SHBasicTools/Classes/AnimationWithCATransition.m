//
//  AnimationWithCATransition.m
//  ZhaoShang
//
//  Created by 慧 on 2020/6/18.
//  Copyright © 2020 慧. All rights reserved.
//

#import "AnimationWithCATransition.h"

// 转场动画持续时间
#define kTransitionDuration 0.5

@implementation AnimationWithCATransition

- (void)pushViewController:(UIViewController *)viewController view:(UIView*)view withCATransitionType:(CATransitionType)type subType:(CATransitionSubtype)subType animated:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CATransition *transition = [CATransition animation];
        transition.duration = kTransitionDuration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = type;
        transition.subtype = subType;
        [view.layer addAnimation:transition forKey:nil];

        //动作，事件
    });
}

@end
