//
//  ShareView.h
//  WisdomPeoples
//
//  Created by 慧 on 2020/12/22.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface SHShareView : UIView

@property (nonatomic,strong) NewsModel* newsModel;

@property (nonatomic,strong) NSString* urlString;

@property (nonatomic,strong) NSString* title;

@property (nonatomic,strong) NSString* text;

@property (nonatomic,strong) NSString* image;


/// 分享平台model
@property (nonatomic,strong) NSMutableArray* shareModelArray;
@end

NS_ASSUME_NONNULL_END
