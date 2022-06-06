//
//  CusstomSheetTableView.h
//  SchoolSystem
//
//  Created by 慧 on 2020/8/5.
//  Copyright © 2020 慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHCusstomTableView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCell)(NSMutableArray* dataArray,NSMutableArray* selectIndexPathArray,BOOL isRadio);

@interface CusstomSheetTableView : UIView<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* _selectIndexPathArray;
    
    NSMutableArray* _selectModelArray;
}
@property (nonatomic,assign) BOOL isRadio;  //单选yes  多选no


@property (nonatomic,strong) NSMutableArray* dataArray;
@property (nonatomic,strong) SHCusstomTableView* tableView;

@property (nonatomic,copy) SelectCell  selectCellBlock;
@end


NS_ASSUME_NONNULL_END
