//
//  SWFormBaseCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseCell.h"
#import "SelwynExpandableTextView.h"
#import "SWFormCompat.h"

@interface SWFormBaseCell()<UITextViewDelegate>
@end

@implementation SWFormBaseCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:SW_TitleFont];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (SelwynExpandableTextView *)expandableTextView {
    if (!_expandableTextView) {
        _expandableTextView = [[SelwynExpandableTextView alloc]init];
        _expandableTextView.delegate = self;
        _expandableTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _expandableTextView.textContainer.lineFragmentPadding = 0;
        _expandableTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _expandableTextView.backgroundColor = [UIColor clearColor];
        _expandableTextView.font = [UIFont systemFontOfSize:SW_InfoFont];
        _expandableTextView.scrollEnabled = NO;
        _expandableTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _expandableTextView.layoutManager.allowsNonContiguousLayout = NO;
        _expandableTextView.showsVerticalScrollIndicator = NO;
        _expandableTextView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_expandableTextView];
    }
    return _expandableTextView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
