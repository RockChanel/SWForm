//
//  SWFormInputCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormInputCell.h"
#import "SWFormItem.h"
#import "SWFormCompat.h"

@implementation SWFormInputCell

- (void)setItem:(SWFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(SW_EdgeMargin, SW_EdgeMargin, SW_TitleWidth, SW_TitleHeight);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation UITableView (SWFormInputCell)

- (SWFormInputCell *)inputCellWithId:(NSString *)cellId
{
    SWFormInputCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SWFormInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
