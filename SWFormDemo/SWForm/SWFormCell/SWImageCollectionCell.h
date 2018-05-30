//
//  SWImageCollectionCell.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SWDeleteImageCompletion)(void);

@interface SWImageCollectionCell : UICollectionViewCell

@property (nonatomic, copy) SWDeleteImageCompletion deleteImageCompletion;
@property (nonatomic, strong) id image;

@end
