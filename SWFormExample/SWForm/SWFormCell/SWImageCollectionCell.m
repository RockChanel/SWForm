//
//  SWImageCollectionCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWImageCollectionCell.h"
#import "SWFormCompat.h"
#import "UIImageView+FormImage.h"
/**
 删除图标宽高
 */
static CGFloat const SWDeleteIconWidth = 22.0f;
/**
 删除按钮宽高，大于图标宽高，增强交互性
 */
static CGFloat const SWDeleteBtnWidth = 25.0f;

@interface SWImageCollectionCell()

@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *deleteIcon;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation SWImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SWDeleteIconWidth/2, self.frame.size.width - SWDeleteIconWidth/2, self.frame.size.height - SWDeleteIconWidth/2)];
        self.currentImageView.clipsToBounds = YES;
        self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.currentImageView];
        
        self.deleteIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - SWDeleteIconWidth, 0, SWDeleteIconWidth, SWDeleteIconWidth)];
        self.deleteIcon.image = [UIImage imageNamed:SW_DeleteIcon];
        [self.contentView addSubview:self.deleteIcon];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.deleteBtn.frame = CGRectMake(self.frame.size.width - SWDeleteBtnWidth, 0, SWDeleteBtnWidth, SWDeleteBtnWidth);
        [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
    }
    return self;
}

- (void)deleteAction {
    if (self.deleteImageCompletion) {
        self.deleteImageCompletion();
    }
}

- (void)setEditable:(BOOL)editable {
    _editable = editable;
    self.deleteBtn.hidden = !editable;
    self.deleteIcon.hidden = !editable;
}

#pragma mark -- 设置当前图片
- (void)setImage:(id)image {
    _image = image;
    if ([image isKindOfClass:[UIImage class]]) {
        self.currentImageView.image = image;
    }
    else if ([image isKindOfClass:[NSURL class]]) {
        [self.currentImageView sw_setImageItemWithUrl:image];
    }
    else if ([image isKindOfClass:[NSString class]]) {
        [self.currentImageView sw_setImageItemWithUrl:[NSURL URLWithString:image]];
    }
    else {
        self.currentImageView.image = [UIImage imageNamed:SW_PlaceholderImage];
    }
}

@end
