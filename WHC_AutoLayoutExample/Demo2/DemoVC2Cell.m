//
//  DemoVC2Cell.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/2/29.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "DemoVC2Cell.h"
#import "UIView+WHC_AutoLayout.h"
#define cellName (@"CellName")
@interface DemoVC2Cell ()<UITableViewDataSource,UITableViewDelegate> {
    UILabel *  _image;
    UILabel *  _title;
    UILabel *  _content;
    UILabel *  _other;
    UITableView * _tableView;
}

@end

@implementation DemoVC2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image = [UILabel new];
        _title = [UILabel new];
        _content = [UILabel new];
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _image.backgroundColor = [UIColor orangeColor];
        _title.backgroundColor = [UIColor grayColor];
        _content.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_content];
        [self.contentView addSubview:_tableView];
        
        _title.text = @"WHC";
        _title.font = [UIFont systemFontOfSize:20];
        _title.textColor = [UIColor redColor];
        
        [_title whc_FrameAutoWidth:WHCWidthAutoRectMake(10, 0, 10, 30)];
        
        _image.textAlignment = NSTextAlignmentCenter;
        [_image whc_LeftSpace:10];
        [_image whc_TopSpace:10 relativeView:_title];
        [_image whc_Size:CGSizeMake(40, 40)];
        
        [_content whc_TopSpace:10 relativeView:_title];
        [_content whc_LeftSpace:10 relativeView:_image];
        [_content whc_RightSpace:10];
        [_content whc_HeightAuto];
        
        _tableView.scrollEnabled = NO;
        [_tableView whc_TopSpace:10 relativeView:_content];
        [_tableView whc_LeftSpace:10];
        [_tableView whc_RightSpace:10];
        self.whc_CellBottomOffset = 10;
        [_tableView whc_Height:44];
        self.whc_CellTableView = _tableView;
    }
    return self;
}

- (void)setContent:(NSString *)content index:(NSInteger)index {
    _content.text = content;
    _image.text = @(index).stringValue;
    [_tableView reloadData];
    [_tableView whc_Height:_tableView.contentSize.height];
    if (index < 5) {
        if (_other == nil) {
            _other = [UILabel new];
            _other.backgroundColor = [UIColor magentaColor];
        }
        _other.text = content;
        if (![self.contentView.subviews containsObject:_other]) {
            [self.contentView addSubview:_other];
            [_other whc_TopSpace:10 relativeView:_tableView];
            [_other whc_LeftSpace:10 relativeView:_image];
            [_other whc_RightSpace:10];
            [_other whc_HeightAuto];
        }
        self.whc_CellBottomView = _other;
    }else {
        if (_other && [self.contentView.subviews containsObject:_other]) {
            [_other removeFromSuperview];
        }
        self.whc_CellBottomView = _tableView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = @"评论列表(cell 嵌套列表演示)";
    return cell;
}
@end
