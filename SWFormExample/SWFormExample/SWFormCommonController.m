//
//  SWFormCommonController.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormCommonController.h"
#import "SWForm.h"
#import "SWFormHandler.h"

@interface SWFormCommonController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *genders;
@property (nonatomic, strong) SWFormItem *name;
@property (nonatomic, strong) SWFormItem *age;
@property (nonatomic, strong) SWFormItem *price;
@property (nonatomic, strong) SWFormItem *gender;
@property (nonatomic, strong) SWFormItem *intro;
@property (nonatomic, strong) SWFormItem *image;

@end

@implementation SWFormCommonController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.genders = @[@"男",@"女"];
    [self datas];
}

/**
 数据源处理
 */
- (void)datas {
    SWWeakSelf
    NSMutableArray *items = [NSMutableArray array];
    
    self.name = SWFormItem_Add(@"姓名", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeDefault);
    self.name.showLength = YES;
    [items addObject:_name];
    
    self.age = SWFormItem_Add(@"年龄", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeNumberPad);
    self.age.maxInputLength = 3;
    self.age.unit = @"岁";
    [items addObject:_age];
    
    self.price = SWFormItem_Add(@"价格", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeNumberPad);
    self.price.maxInputLength = 5;
    self.price.itemUnitType = SWFormItemUnitTypeYuan;
    [items addObject:_price];
    
    self.gender = SWFormItem_Add(@"性别", nil, SWFormItemTypeSelect, NO, YES, UIKeyboardTypeDefault);
    self.gender.itemSelectCompletion = ^(SWFormItem *item) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"请选择%@",item.title] delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        for (int i = 0; i < weakSelf.genders.count; i++) {
            [actionSheet addButtonWithTitle:weakSelf.genders[i]];
        }
        actionSheet.tag = 10;
        [actionSheet showInView:weakSelf.view];
    };
    [items addObject:_gender];
    
    self.intro = SWFormItem_Add(@"个人简介", @"这是个人简介", SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    self.intro.showLength = YES;
    [items addObject:_intro];
    
    self.image = SWFormItem_Add(@"附件", nil, SWFormItemTypeImage, YES, NO, UIKeyboardTypeDefault);
    self.image.images = @[@"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=f04093d6da00baa1ae214ffb2e68dc7e/34fae6cd7b899e5160ce642e49a7d933c8950d43.jpg", @"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=b360ab28790e0cf3b4fa46bb633e9773/e850352ac65c10387071c8f8b9119313b07e89f8.jpg", @""];
    [items addObject:_image];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    //    sectionItem.headerHeight = 10;
    //    sectionItem.footerView = [self footerView];
    //    sectionItem.footerHeight = 80;
    [self.mutableItems addObject:sectionItem];
    
    self.formTableView.tableFooterView = [self footerView];
}

/**
 创建footer
 */
- (UIView *)footerView {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.bounds = CGRectMake(0, 0, 100, 40);
    submitBtn.center = footer.center;
    submitBtn.backgroundColor = [UIColor orangeColor];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:submitBtn];
    
    return footer;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        if (buttonIndex != 0) {
            self.gender.info = self.genders[buttonIndex-1];
            [self.formTableView reloadData];
        }
    }
}

- (void)submitAction {
    [SWFormHandler sw_checkFormNullDataWithWithDatas:self.mutableItems success:^{
        
        NSLog(@"selectImages === %@", self.image.selectImages);
        //NSLog(@"images === %@", image.images);
        NSLog(@"gender === %@", self.gender.info);
        NSLog(@"name === %@", self.name.info);
        
    } failure:^(NSString *error) {
        NSLog(@"error====%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
