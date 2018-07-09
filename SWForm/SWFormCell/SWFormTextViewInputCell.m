//
//  SWFormTextViewInputCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormTextViewInputCell.h"
#import "SWFormItem.h"
#import "SelwynExpandableTextView.h"
#import "SWFormCompat.h"
#import "UITextView+TextLimit.h"
#import "NSString+SWForm.h"

@interface SWFormTextViewInputCell()<UITextViewDelegate>
@end

@implementation SWFormTextViewInputCell

- (void)setItem:(SWFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextView.text = [item.info addUnit:item.unit];
    self.expandableTextView.attributedPlaceholder = item.attributedPlaceholder;
    self.expandableTextView.editable = item.editable;
    self.expandableTextView.keyboardType = item.keyboardType;
    self.expandableTextView.currentLength = item.info.length;
    self.expandableTextView.showLength = item.showLength;
    self.expandableTextView.maxLength = item.maxInputLength;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(SW_EdgeMargin, SW_EdgeMargin, SW_SCRREN_WIDTH - 2*SW_EdgeMargin, SW_TitleHeight);
    
    //重置 expandableTextView 内边距
    self.expandableTextView.textContainerInset = UIEdgeInsetsMake(SW_EdgeMargin, SW_EdgeMargin, SW_EdgeMargin, SW_EdgeMargin);
    self.expandableTextView.backgroundColor = SW_TEXTVIEW_BACKGROUNDCOLOR;
    
    CGFloat newHeight = [SWFormTextViewInputCell heightWithItem:self.item];
    self.expandableTextView.frame = CGRectMake(SW_EdgeMargin, CGRectGetMaxY(self.titleLabel.frame) + SW_EdgeMargin, SW_SCRREN_WIDTH - 2*SW_EdgeMargin, newHeight - 3*SW_EdgeMargin - SW_TitleHeight);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.expandableTextView.text = self.item.info;
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.item.maxInputLength > 0) {
        [self.expandableTextView textLimitWithMaxLength:self.item.maxInputLength];
    }
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
    if (self.textViewInputCompletion) {
        self.textViewInputCompletion(self.expandableTextView.text);
    }
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
    self.expandableTextView.text = [self.item.info addUnit:self.item.unit];
}

+ (CGFloat)heightWithItem:(SWFormItem *)item {
    CGFloat infoHeight = [item.info sizeWithFontSize:SW_InfoFont maxSize:CGSizeMake(SW_SCRREN_WIDTH - 4*SW_EdgeMargin, MAXFLOAT)].height;
    return MAX(item.defaultHeight, infoHeight + SW_TitleHeight + 5*SW_EdgeMargin);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation UITableView (SWFormTextViewInputCell)

- (SWFormTextViewInputCell *)textViewInputCellWithId:(NSString *)cellId
{
    SWFormTextViewInputCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SWFormTextViewInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
