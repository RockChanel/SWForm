//
//  SWFormBaseCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelwynExpandableTextView;

@interface SWFormBaseCell : UITableViewCell

@property (nonatomic, strong) SelwynExpandableTextView *expandableTextView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) UITableView *expandableTableView;

@end
