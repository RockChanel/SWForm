//
//  SWFormImageCell.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/30.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormImageCell.h"
#import "SWFormItem.h"
#import "SWImageCollectionCell.h"
#import "SWFormCompat.h"
#import "SWFormImageCell+ImageHandle.h"

static NSString *image_cell_id = @"image_cell_id";
static CGFloat const SW_ImageWidth = 80.0f;
static NSInteger const SW_RowImageCount = 4;

@interface SWFormImageCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UICollectionView *imageCollection;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) NSMutableArray *mutableImages;

@end

@implementation SWFormImageCell

- (void)setItem:(SWFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.selectBtn.enabled = item.editable;
    self.mutableImages = [NSMutableArray arrayWithArray:item.images];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(SW_EdgeMargin, SW_EdgeMargin, SW_TitleWidth, SW_TitleHeight);
    self.icon.frame = CGRectMake(self.frame.size.width - 38, SW_EdgeMargin + 2, 23, SW_TitleHeight - 4);
    self.selectBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.item.defaultHeight);
    
    if (self.mutableImages.count > 0) {
        self.imageCollection.frame = CGRectMake(0, self.item.defaultHeight, self.frame.size.width, self.frame.size.height - self.item.defaultHeight);
        self.imageCollection.hidden = NO;
        [self.imageCollection reloadData];
    }
    else {
        self.imageCollection.frame = CGRectZero;
        self.imageCollection.hidden = YES;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mutableImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:image_cell_id forIndexPath:indexPath];
    cell.image = self.mutableImages[indexPath.item];
    cell.editable = self.item.editable;
    cell.deleteImageCompletion = ^{
        [self.mutableImages removeObjectAtIndex:indexPath.item];
        [self sw_reloadData];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self sw_photoBrowserWithImages:self.mutableImages currentIndex:indexPath.item];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SW_ImageWidth, SW_ImageWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (void)selectImageAction {
    if (self.mutableImages.count >= self.item.maxImageCount) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"最多选择%ld张附件",(long)self.item.maxImageCount] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    // 选择图片事件函数
    [self sw_selectImageWithMaxImages:self.item.maxImageCount currentImages:self.mutableImages.count completion:^(NSArray *selectImages) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.mutableImages addObjectsFromArray:selectImages];
        [strongSelf sw_reloadData];
    }];
}

#pragma mark -- 刷新当前图片数据
- (void)sw_reloadData {
    if (self.imageCompletion) {
        self.imageCompletion(self.mutableImages);
    }
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

+ (CGFloat)heightWithItem:(SWFormItem *)item {
    NSInteger rows = item.images.count%SW_RowImageCount > 0 ? item.images.count/SW_RowImageCount+1:item.images.count/SW_RowImageCount;
    return item.images.count > 0 ? item.defaultHeight + 10*(rows+1) + rows*SW_ImageWidth:item.defaultHeight;
}

#pragma mark -- 懒加载实现
- (NSMutableArray *)mutableImages {
    if (!_mutableImages) {
        _mutableImages = [[NSMutableArray alloc]init];
    }
    return _mutableImages;
}

- (UICollectionView *)imageCollection {
    if (!_imageCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        _imageCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _imageCollection.backgroundColor = [UIColor whiteColor];
        _imageCollection.delegate = self;
        _imageCollection.dataSource = self;
        _imageCollection.hidden = YES;
        _imageCollection.scrollEnabled = NO;
        _imageCollection.showsVerticalScrollIndicator = NO;
        _imageCollection.showsHorizontalScrollIndicator = NO;
        [_imageCollection registerClass:[SWImageCollectionCell class] forCellWithReuseIdentifier:image_cell_id];
        [self.contentView addSubview:_imageCollection];
    }
    return _imageCollection;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectBtn addTarget:self action:@selector(selectImageAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SWForm.bundle/SWImageIcon"]];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


@implementation UITableView (SWFormImageCell)

- (SWFormImageCell *)imageCellWithId:(NSString *)cellId
{
    SWFormImageCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SWFormImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}
@end
