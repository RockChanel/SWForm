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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
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
    
    static NSString *input_cell_id = @"input_cell_id";
    SWFormInputCell *cell = [tableView inputCellWithId:input_cell_id];
    cell.item = item;
    return cell;
}

#pragma mark -- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
