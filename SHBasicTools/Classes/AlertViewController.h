//
//  AlertViewController.h
//  HaoDanBao
//
//  Created by 慧 on 2019/6/11.
//  Copyright © 2019 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertViewController : UIAlertController

+ (instancetype)initAlertControllerWithTitle:(nullable NSString*)title massege:(nullable NSString*)massege style:(UIAlertControllerStyle)style actionTitleArr:(NSArray *)actionTitleArr alertAction:(void (^)(UIAlertAction*) )alertAction logoImageString:(nullable NSString*)logoImageString;

- (void)showAlertController;
@end

NS_ASSUME_NONNULL_END
