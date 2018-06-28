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

typedef void(^GenderSelectCompletion)(NSInteger index);

@interface SWFormCommonController ()<UIActionSheetDelegate>

@property (nonatomic, copy) GenderSelectCompletion genderSelectCompletion;
@property (nonatomic, strong) NSArray *genders;

@end

@implementation SWFormCommonController

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
    NSMutableArray *items = [NSMutableArray array];
    
    SWFormItem *name = SWFormItem_Add(@"姓名", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeDefault);
    name.showLength = YES;
    [items addObject:name];
    
    SWFormItem *age = SWFormItem_Add(@"年龄", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeNumberPad);
    age.maxInputLength = 3;
    age.unit = @"岁";
    [items addObject:age];
    
    SWFormItem *price = SWFormItem_Add(@"价格", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeNumberPad);
    price.maxInputLength = 5;
    price.itemUnitType = SWFormItemUnitTypeYuan;
    [items addObject:price];
    
    SWFormItem *gender = SWFormItem_Add(@"性别", nil, SWFormItemTypeSelect, NO, YES, UIKeyboardTypeDefault);
    gender.itemSelectCompletion = ^(SWFormItem *item) {
        [self selectGenderWithItem:item];
    };
    [items addObject:gender];
    
    SWFormItem *intro = SWFormItem_Add(@"个人简介", @"这是个人简介", SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    intro.showLength = YES;
    [items addObject:intro];
    
    SWFormItem *image = SWFormItem_Add(@"附件", nil, SWFormItemTypeImage, YES, NO, UIKeyboardTypeDefault);
    image.images = @[@"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=f04093d6da00baa1ae214ffb2e68dc7e/34fae6cd7b899e5160ce642e49a7d933c8950d43.jpg", @"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=b360ab28790e0cf3b4fa46bb633e9773/e850352ac65c10387071c8f8b9119313b07e89f8.jpg", @""];
    [items addObject:image];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    //    sectionItem.headerHeight = 10;
    //    sectionItem.footerView = [self footerView];
    //    sectionItem.footerHeight = 80;
    [self.mutableItems addObject:sectionItem];
    
    self.formTableView.tableFooterView = [self footerView];
    
    // 性别选择事件回调
    __weak typeof(self) weakSelf = self;
    self.genderSelectCompletion = ^(NSInteger index) {
        if (index!=0) {
            gender.info = weakSelf.genders[index-1];
            [weakSelf.formTableView reloadData];
        }
    };
    
    // 确定按钮点击事件回调
    self.submitCompletion = ^{
        
        NSLog(@"提交按钮点击");
        // 这里只是简单描述校验逻辑，可根据自身需求封装数据校验逻辑
        [SWFormHandler sw_checkFormNullDataWithWithDatas:weakSelf.mutableItems success:^{
            
            NSLog(@"selectImages === %@", image.selectImages);
            //NSLog(@"images === %@", image.images);
            NSLog(@"gender === %@", gender.info);
            NSLog(@"name === %@", name.info);
            
        } failure:^(NSString *error) {
            NSLog(@"error====%@",error);
        }];
    };
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

- (void)selectGenderWithItem:(SWFormItem *)item{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"请选择%@",item.title] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (int i = 0; i < self.genders.count; i++) {
        [actionSheet addButtonWithTitle:self.genders[i]];
    }
    actionSheet.tag = 10;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        self.genderSelectCompletion(buttonIndex);
    }
}

- (void)submitAction {
    self.submitCompletion();
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
