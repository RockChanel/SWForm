//
//  SWFormInfoController.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/31.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormInfoController.h"
#import "SWForm.h"

typedef void(^EditCompletion)(void);

@interface SWFormInfoController ()

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, copy)EditCompletion editCompletion;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation SWFormInfoController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.editBtn sizeToFit];
    [self.editBtn addTarget:self action:@selector(editeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    self.navigationItem.rightBarButtonItem = editItem;
    
    [self datas];
}

/**
 数据源处理
 */
- (void)datas {
    NSMutableArray *items = [NSMutableArray array];
    SWFormItem *name = SWFormItem_Info(@"姓名", @"selwyn", SWFormItemTypeInput);
    name.keyboardType = UIReturnKeyDefault;
    [items addObject:name];
    
    SWFormItem *age = SWFormItem_Info(@"年龄", @"14", SWFormItemTypeInput);
    age.keyboardType = UIKeyboardTypeNumberPad;
    [items addObject:age];
    
    SWFormItem *image = SWFormItem_Info(@"图片附件", nil, SWFormItemTypeImage);
    image.images = @[@"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=f04093d6da00baa1ae214ffb2e68dc7e/34fae6cd7b899e5160ce642e49a7d933c8950d43.jpg", @"http://imgsrc.baidu.com/image/c0%3Dpixel_huitu%2C0%2C0%2C294%2C40/sign=b360ab28790e0cf3b4fa46bb633e9773/e850352ac65c10387071c8f8b9119313b07e89f8.jpg", @""];
    [items addObject:image];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    [self.mutableItems addObject:sectionItem];
    
    __weak typeof(self) weakSelf = self;
    
    // 编辑按钮点击事件回调
    self.editCompletion = ^{
        
        weakSelf.isEditing = !weakSelf.isEditing;
        name.editable = weakSelf.isEditing;
        age.editable = weakSelf.isEditing;
        image.editable = weakSelf.isEditing;
        
        if (weakSelf.isEditing) {
            NSLog(@"====编辑中====");
        }
        else {
            NSLog(@"====完成编辑====");
        }
        
        [weakSelf.formTableView reloadData];
    };
}

- (void)editeAction {
    self.editCompletion();
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    [self.editBtn setTitle:isEditing ? @"完成":@"编辑" forState:UIControlStateNormal];
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
