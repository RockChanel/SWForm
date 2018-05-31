//
//  SWFormCommonController.m
//  SWFormDemo
//
//  Created by zijin on 2018/5/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SWFormCommonController.h"
#import "SWForm.h"

@interface SWFormCommonController ()

@end

@implementation SWFormCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *items = [NSMutableArray array];
    
    SWFormItem *name = SWFormItem_Add(@"姓名", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeDefault);
    [items addObject:name];
    
    SWFormItem *age = SWFormItem_Add(@"年龄", nil, SWFormItemTypeInput, YES, YES, UIKeyboardTypeNumberPad);
    [items addObject:age];
    
    SWFormItem *gender = SWFormItem_Add(@"性别", nil, SWFormItemTypeSelect, NO, YES, UIKeyboardTypeDefault);
    [items addObject:gender];
    
    SWFormItem *intro = SWFormItem_Add(@"个人简介", nil, SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    [items addObject:intro];
    
    SWFormItem *image = SWFormItem_Add(@"附件", nil, SWFormItemTypeImage, YES, NO, UIKeyboardTypeDefault);
    [items addObject:image];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    
    [self.mutableItems addObject:sectionItem];
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
