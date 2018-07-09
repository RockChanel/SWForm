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
#import "SelwynExpandableTextView.h"
#import "UITextView+TextLimit.h"
#import "NSString+SWForm.h"

@interface SWFormInputCell()<UITextViewDelegate>
@end

@implementation SWFormInputCell

- (void)setItem:(SWFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextView.text = [item.info addUnit:item.unit];
    self.expandableTextView.attributedPlaceholder = item.attributedPlaceholder;
    self.expandableTextView.editable = item.editable;
    self.expandableTextView.keyboardType = item.keyboardType;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(SW_EdgeMargin, SW_EdgeMargin, SW_TitleWidth, SW_TitleHeight);
    
    CGFloat newHeight = [SWFormInputCell heightWithItem:self.item];
    self.expandableTextView.frame = CGRectMake(SW_TitleWidth + 2*SW_EdgeMargin, SW_EdgeMargin, SW_SCRREN_WIDTH - (SW_TitleWidth + 3*SW_EdgeMargin), newHeight - 2*SW_EdgeMargin);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.expandableTextView.text = self.item.info;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.item.maxInputLength > 0) {
        // 限制输入字数
        [self.expandableTextView textLimitWithMaxLength:self.item.maxInputLength];
    }
    if (self.inputCompletion) {
        self.inputCompletion(self.expandableTextView.text);
    }
    // 防止输入时表单因刷新动画抖动
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.expandableTextView.text = [self.item.info addUnit:self.item.unit];
}

+ (CGFloat)heightWithItem:(SWFormItem *)item {
    CGFloat infoHeight = [item.info sizeWithFontSize:SW_InfoFont maxSize:CGSizeMake(SW_SCRREN_WIDTH - (SW_TitleWidth + 3*SW_EdgeMargin), MAXFLOAT)].height;
    return MAX(item.defaultHeight, infoHeight + 2*SW_EdgeMargin);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
