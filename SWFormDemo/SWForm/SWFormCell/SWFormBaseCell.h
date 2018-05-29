//
//  SWFormBaseCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelwynExpandableTextView;

/**
 SWFormBaseCell 表单条目基类，所有表单条目都继承于BaseCell
 */
@interface SWFormBaseCell : UITableViewCell

@property (nonatomic, strong) SelwynExpandableTextView *expandableTextView;

/**
 表单标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 表单条目所在的tableView
 */
@property (nonatomic, weak) UITableView *expandableTableView;

@end
