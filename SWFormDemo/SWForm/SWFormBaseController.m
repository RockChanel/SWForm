//
//  SWFormBaseController.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormBaseController.h"
#import "SWForm.h"
#import "SWFormInputCell.h"
#import "SWFormTextViewInputCell.h"
#import "SWFormSelectCell.h"
#import "SWFormImageCell.h"

@interface SWFormBaseController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly) UITableViewStyle style;
@end

@implementation SWFormBaseController

- (NSMutableArray *)mutableItems {
    if (!_mutableItems) {
        _mutableItems = [[NSMutableArray alloc]init];
    }
    return _mutableItems;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:_style];
    [self addChildViewController:tableViewController];
    [tableViewController.view setFrame:self.view.bounds];
    
    _formTableView = tableViewController.tableView;
    _formTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _formTableView.dataSource = self;
    _formTableView.delegate = self;
    _formTableView.showsVerticalScrollIndicator = NO;
    _formTableView.showsHorizontalScrollIndicator = NO;
    _formTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_formTableView];
}

#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert([self.mutableItems[section] isKindOfClass:[SWFormSectionItem class]]);
    SWFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    NSParameterAssert([sectionItem.items[indexPath.row] isKindOfClass:[SWFormItem class]]);
    SWFormItem *item = sectionItem.items[indexPath.row];
    
    if (item.itemType == SWFormItemTypeTextViewInput) {
        static NSString *textViewInput_cell_id = @"textViewInput_cell_id";
        SWFormTextViewInputCell *cell = [tableView textViewInputCellWithId:textViewInput_cell_id];
        cell.item = item;
        cell.textViewInputCompletion = ^(NSString *text) {
            [self updateTextViewInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
    else if (item.itemType == SWFormItemTypeSelect) {
        static NSString *select_cell_id = @"select_cell_id";
        SWFormSelectCell *cell = [tableView selectCellWithId:select_cell_id];
        cell.item = item;
        return cell;
    }
    else if (item.itemType == SWFormItemTypeImage) {
        static NSString *image_cell_id = @"image_cell_id";
        SWFormImageCell *cell = [tableView imageCellWithId:image_cell_id];
        cell.item = item;
        return cell;
    }
    else {
        static NSString *input_cell_id = @"input_cell_id";
        SWFormInputCell *cell = [tableView inputCellWithId:input_cell_id];
        cell.item = item;
        cell.inputCompletion = ^(NSString *text) {
            [self updateInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
}

#pragma mark -- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    SWFormItem *item = sectionItem.items[indexPath.row];
    if (item.itemType == SWFormItemTypeTextViewInput) {
        return [SWFormTextViewInputCell heightWithItem:item];
    }
    else if (item.itemType == SWFormItemTypeSelect) {
        return [SWFormSelectCell heightWithItem:item];
    }
    else if (item.itemType == SWFormItemTypeImage) {
        return [SWFormImageCell heightWithItem:item];
    }
    else {
        return [SWFormInputCell heightWithItem:item];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    SWFormItem *item = sectionItem.items[indexPath.row];
    
}

#pragma mark -- TableViewCell 响应block处理
- (void)updateInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    SWFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    SWFormItem *item = sectionItem.items[indexPath.row];
    item.info = text;
}

- (void)updateTextViewInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    SWFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    SWFormItem *item = sectionItem.items[indexPath.row];
    item.info = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
