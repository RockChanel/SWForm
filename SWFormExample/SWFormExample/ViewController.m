//
//  ViewController.m
//  SWFormExample
//
//  Created by zijin on 2018/6/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "ViewController.h"
#import "SWFormCommonController.h"
#import "SWFormInfoController.h"

static NSString *const kTitle = @"title";
static NSString *const kId = @"id";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = @[
                   @{kTitle:@"SWForm", kId:@"1"},
                   @{kTitle:@"SWFormInfo", kId:@"2"},
                   ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"home_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = self.datas[indexPath.row][kTitle];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempId = self.datas[indexPath.row][kId];
    if ([tempId isEqualToString:@"1"]) {
        SWFormCommonController *commonVC = [[SWFormCommonController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:commonVC animated:YES];
    }
    else if ([tempId isEqualToString:@"2"]){
        SWFormInfoController *infoVC = [[SWFormInfoController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
