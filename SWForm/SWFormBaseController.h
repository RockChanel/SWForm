//
//  SWFormBaseController.h
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 SWFormBaseController 表单基类，所有表单必须继承于BaseController，实现了表单动态配置
 */
@interface SWFormBaseController : UIViewController

/**
 表单tableView
 */
@property (nonatomic, strong) UITableView *formTableView;

/**
 表单数据源，数据源格式应为 @[SWFormSection..]，否则断言会直接崩溃
 */
@property (nonatomic, strong) NSMutableArray *mutableItems;

/**
 表单页面初始化方法
 
 @param style 表单tableView样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
