//
//  SWFormSelectCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormSelectCell.h"
#import "SWFormItem.h"
#import "SelwynExpandableTextView.h"
#import "SWFormCompat.h"
#import "NSString+SWForm.h"

@implementation SWFormSelectCell

- (void)setItem:(SWFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextView.text = [item.info addUnit:item.unit];
    self.expandableTextView.attributedPlaceholder = item.attributedPlaceholder;
    self.expandableTextView.editable = item.editable;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(SW_EdgeMargin, (self.item.defaultHeight - SW_TitleHeight)/2, SW_TitleWidth, SW_TitleHeight);
    self.expandableTextView.userInteractionEnabled = NO;
    
    CGFloat newHeight = [SWFormSelectCell heightWithItem:self.item];
    self.expandableTextView.frame = CGRectMake(SW_TitleWidth + 2*SW_EdgeMargin, SW_EdgeMargin, SW_SCRREN_WIDTH - (SW_TitleWidth + 2*SW_EdgeMargin + 30),  newHeight - 2*SW_EdgeMargin);
}

+ (CGFloat)heightWithItem:(SWFormItem *)item {
    CGFloat infoHeight = [item.info sizeWithFontSize:SW_InfoFont maxSize:CGSizeMake(SW_SCRREN_WIDTH - SW_TitleWidth - 2*SW_EdgeMargin - 30, MAXFLOAT)].height;
    return MAX(item.defaultHeight, infoHeight + 2*SW_EdgeMargin);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation UITableView (SWFormSelectCell)

- (SWFormSelectCell *)selectCellWithId:(NSString *)cellId
{
    SWFormSelectCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SWFormSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
