//
//  ViewController.m
//  testSheetView
//
//  Created by ekhome on 16/11/2.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "PFSheetView.h"
#import "UILabel+Font.h"
#import <objc/runtime.h>
@interface ViewController ()<PFSheetViewDelegate>
{

    UIAlertAction * action;
    UIAlertController *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:btn];
    [btn setTitle:@"点击我啊" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
}

-(void)test1{
    v = [UIAlertController alertControllerWithTitle:@"test1" message:@"qweytrdu" preferredStyle:UIAlertControllerStyleActionSheet];
   UIAlertAction *ac = [UIAlertAction actionWithTitle:@"有图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"3456");
   }];
    UIImage *accessoryImage = [UIImage imageNamed:@"list_weixin"];
    accessoryImage = [accessoryImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [ac setValue:accessoryImage forKey:@"image"];
    [v addAction:ac];
    action = [UIAlertAction actionWithTitle:@"18611996469" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [v dismissViewControllerAnimated:YES completion:nil];
    }];
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedInInstancesOfClasses:@[v.class]];
    [appearanceLabel changeFont:[UIFont systemFontOfSize:28]];
    // 修改字体颜色
    [action setValue:[UIColor greenColor] forKey:@"_titleTextColor"];
    [v addAction:action];
    UIAlertAction * acti = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [v dismissViewControllerAnimated:YES completion:nil];
    }];
    [v addAction:acti];
    [self runtimeProperty];
    [self runtimeMethod];
    [self presentViewController:v animated:YES completion:nil];
}

/**
 *  获取UIAlertController属性名
 */
- (void)runtimeProperty {
    unsigned int count = 0;
//    这里获取的是UIAlertAction这个类的所有的属性  和 类型 class_copyIvarList复制常用列表里面的所有的对应类的属性
//    所以获取到的message可以说是UIAlertAction对应的某个的属性
//     改变其内容实质上就是替换了原有的value或者是直接替换对应的控价 调用 object_setIvar(<#id obj#>, <#Ivar ivar#>, <#id value#>)
    Ivar *property = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = property[i];
        const char *name = ivar_getName(var);
        const char *type = ivar_getTypeEncoding(var);
        NSLog(@"%s =====ppppppp========== %s---------%ld\n***\n***\n",name,type,(long)i);
    }
    Ivar message = property[13];
//    /**
//     *  字体修改
//     */
//    UIFont *big = [UIFont systemFontOfSize:25];
//    UIFont *small = [UIFont systemFontOfSize:18];
//    UIColor *red = [UIColor redColor];
//    UIColor *blue = [UIColor blueColor];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"this is a " attributes:@{NSFontAttributeName:big,NSForegroundColorAttributeName:red,}];
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.alignment = NSTextAlignmentLeft;//设置对齐方式
//    [str setAttributes:@{NSFontAttributeName:small} range:NSMakeRange(0, 2)];
//    [str setAttributes:@{NSForegroundColorAttributeName:blue} range:NSMakeRange(0, 4)];
//    [str setAttributes:@{NSParagraphStyleAttributeName:paragraph} range:NSMakeRange(0, 4)];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor orangeColor];
    UIButton *btn = [UIButton new];
    [vc.view addSubview:btn];
    CGRect rect = vc.view.frame;
    btn.frame = CGRectMake(CGRectGetWidth(rect)*3/4, 0, 100, 200);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    object_setIvar(action, message, vc);
    
}

-(void)click{
    NSLog(@"qwrtyuu");
}

- (void)runtimeMethod{
    unsigned int count = 0;
    Method *alertMethod = class_copyMethodList([UIAlertController class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(alertMethod[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"methodName ============= %@",methodName);
    }
}



//
//-(void)test{
//    PFSheetView *v = [[PFSheetView alloc]initWithTitle:@"我是用来测试的" andMeaasge:@"这里可以不用写任何东西"];
//    v.delegate = self;
//    v.actionTitles = @[@"支付宝",@"微信支付",@"一网通支付",@"取消"];
//    [v showWityController:self];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sheetView:(PFSheetView *)sheetView didSelectAtIndex:(NSInteger)index
{
    if (index < sheetView.actionTitles.count - 1) {
        
        NSLog(@"%ld",(long)index);
    };
}


//返回Action的样式
- (UIAlertActionStyle)sheetView:(PFSheetView *)sheetView actionStyleAtIndex:(NSInteger)index {
    
    NSLog(@"index----------------%ld",(long)index);
    
    if (index == 0) {
        return UIAlertActionStyleDestructive;
    }else if (index == sheetView.actionTitles.count - 1) {
        
        return UIAlertActionStyleCancel;
    }
    
    return UIAlertActionStyleDefault;
}
/*
 
 
 
 -(void)test{
 PFSheetView *v = [[PFSheetView alloc]initWithTitle:@"我是用来测试的" andMeaasge:@"这里可以不用写任何东西"];
 v.delegate = self;
 v.actionTitles = @[@"支付宝",@"微信支付",@"一网通支付",@"取消"];
 [v showWityController:self];
 }
 
 #pragma mark -PFSheetViewDelegate   - 点击的代理方法       &     每一个PFSheetViewAction的类型
 -(void)sheetView:(PFSheetView *)sheetView didSelectAtIndex:(NSInteger)index
 {
 if (index < sheetView.actionTitles.count - 1) {
 //        DO anything what you wangt to do
 NSLog(@"%ld",(long)index);
 }else {
 NSLog(@"点击的是最后一个按钮%ld",(long)index);
 };
 }
 
 //  此方法非必须实现的代理方法    不实现此方法默认样式为Default
 //- (UIAlertActionStyle)sheetView:(PFSheetView *)sheetView actionStyleAtIndex:(NSInteger)index {
 //    if (index == 0) {
 //        return UIAlertActionStyleDestructive;
 //    }else if (index == sheetView.actionTitles.count - 1) {
 //        return UIAlertActionStyleCancel;
 //    }
 //    return UIAlertActionStyleDefault;
 //}
 
 
 */

@end
