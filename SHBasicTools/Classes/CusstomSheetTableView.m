//
//  CusstomSheetTableView.m
//  SchoolSystem
//
//  Created by 慧 on 2020/8/5.
//  Copyright © 2020 慧. All rights reserved.
//

#import "CusstomSheetTableView.h"

@implementation CusstomSheetTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndexPathArray = [NSMutableArray array];
        _selectModelArray = [NSMutableArray array];

        UIView* bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.3;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        UIView* whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = bg_Color;
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(keySCREEN_HEIGHT / 3);
        }];
                
        UILabel* titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = UIColorFromRGBAlpha(0x1E1E20, 1);
        titleLabel.font = [UIFont systemFontOfSize:CONVER_VALUE(17.0f)];
        titleLabel.text = @"选择付款方式";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(CONVER_VALUE(50.0f));
        }];
        
        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setImage:kGetImage(@"main_pay_back") forState:UIControlStateNormal];
//        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelButton setTitleColor:white_Color forState:UIControlStateNormal];
//        cancelButton.backgroundColor = UIColorFromRGBAlpha(0x999999, 1);
//        cancelButton.layer.cornerRadius = CONVER_VALUE(5.0f);
//        cancelButton.layer.masksToBounds = YES;
        [cancelButton addTarget:self action:@selector(tapGesture) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(CONVER_VALUE(10.0f));
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.width.mas_equalTo(CONVER_VALUE(25.0f));
            make.height.mas_equalTo(25.0f);
        }];

        UIButton* sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:white_Color forState:UIControlStateNormal];
        sureButton.backgroundColor = Main_Color;
        sureButton.layer.cornerRadius = CONVER_VALUE(5.0f);
        sureButton.layer.masksToBounds = YES;
        [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [whiteView addSubview:sureButton];
//        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(CONVER_VALUE(- 10.0f));
//            make.top.width.height.mas_equalTo(cancelButton);
//        }];
        
//        UILabel* lineLabel = [[UILabel alloc]init];
//        lineLabel.backgroundColor = line_Color;
//        [whiteView addSubview:lineLabel];
//        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.mas_equalTo(cancelButton.mas_bottom).offset(CONVER_VALUE(7.0f));
//            make.height.mas_equalTo(CONVER_VALUE(0.5f));
//        }];
        
        SHCusstomTableView* tableView = [[SHCusstomTableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = white_Color;
        tableView.estimatedRowHeight = 200;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.tableHeaderView = [UIView new];
        tableView.tableFooterView = [UIView new];
        tableView.separatorColor = UIColorFromRGBAlpha(0xF9F9F9, 1);
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [whiteView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
        _tableView = tableView;
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [bgView addGestureRecognizer:tapGesture];
    }
    return self;
}
#pragma mark    取消
- (void)tapGesture{
    [self removeFromSuperview];
}
#pragma mark    确定
- (void)sureButtonClick:(UIButton*)button{
    if (self.selectCellBlock) {
        //        self.selectCellBlock(_dataArray, _selectIndexPathArray, _isRadio);
        self.selectCellBlock(_selectModelArray, _selectIndexPathArray, _isRadio);
    }
    [self removeFromSuperview];
    [_selectModelArray removeAllObjects];
    [_selectIndexPathArray removeAllObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SHMenuModel* model  = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString StringConverWithString:model.dictLabel];
    cell.imageView.image = kGetImage([NSString StringConverWithString:model.dictLabel]);
    if ([_selectIndexPathArray containsObject:indexPath]) {
        [NSString setAccessoryView:cell imageName:@"main_pay_select"];
    }else{
        [NSString setAccessoryView:cell imageName:@" "];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SHMenuModel* model  = _dataArray[indexPath.row];

    if (_isRadio == YES) {
        //单选
        [_selectModelArray removeAllObjects];
        if (![_selectModelArray containsObject:model]) {
            [_selectModelArray addObject:model];
        }

        [_selectIndexPathArray removeAllObjects];
        if (![_selectIndexPathArray containsObject:indexPath]) {
            [_selectIndexPathArray addObject:indexPath];
        }
    }else{
        if (![_selectIndexPathArray containsObject:indexPath]) {
            [_selectIndexPathArray addObject:indexPath];
        }else{
            [_selectIndexPathArray removeObject:indexPath];
        }
        
        if (![_selectModelArray containsObject:model]) {
            [_selectModelArray addObject:model];
        }else{
            [_selectModelArray removeObject:model];
        }
    }
    [tableView reloadData];
    
    if (self.selectCellBlock) {
        //        self.selectCellBlock(_dataArray, _selectIndexPathArray, _isRadio);
        self.selectCellBlock(_selectModelArray, _selectIndexPathArray, _isRadio);
    }
    [self removeFromSuperview];
    [_selectModelArray removeAllObjects];
    [_selectIndexPathArray removeAllObjects];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
