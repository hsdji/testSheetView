//
//  PFSheetView.m
//  SheetView
//
//  Created by ekhome on 16/11/1.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "PFSheetView.h"
//添加私有的全局对象
@interface PFSheetView ()
@property (nonatomic,strong)UIAlertController *alert;
@end


@implementation PFSheetView
#pragma mark - publick
-(instancetype)initWithTitle:(NSString *)title andMeaasge:(NSString *)massage
{
   self = [super init];
    if (self)
    {
        _alert = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleActionSheet];
    }
    return self;
}

- (void)showWityController:(UIViewController *)controller{
    //在相应的Controller中弹出弹窗
      [controller presentViewController:_alert animated:YES completion:nil];
}
#pragma mark setter
//重写数组声明的setter方法
-(void)setActionTitles:(NSArray <NSString *> *)actionTitles
{
    //对属性赋值
    _actionTitles = actionTitles;
    //for循环创建Action
    for (int i = 0; i < actionTitles.count; i++) {
        //如果通过代理返回了Action的样式，则根据返回的样式设置相应Action的样式
        if ([self.delegate respondsToSelector:@selector(sheetView:actionStyleAtIndex:)]) {
            UIAlertActionStyle style = [self.delegate sheetView:self actionStyleAtIndex:i];
            UIAlertAction * action = [UIAlertAction actionWithTitle:actionTitles[i] style:style handler:^(UIAlertAction * _Nonnull action) {
              
                
                
                //在此设置Action的点击代理方法
                if ([self.delegate respondsToSelector:@selector(sheetView:didSelectAtIndex:)]) {
                
                    [self.delegate sheetView:self didSelectAtIndex:i];
                }
                //点击之后返回到当前界面
                [_alert dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [_alert addAction:action];
        }else {
            //如果没有返回Action样式，则默认设置为UIAlertActionStyleDefault
            UIAlertAction * action = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //在此设置Action的点击代理方法
                
             
                
                if ([self.delegate respondsToSelector:@selector(sheetView:didSelectAtIndex:)]) {
                    
                    [self.delegate sheetView:self didSelectAtIndex:i];
                }
                //点击之后返回到当前界面
                [_alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [_alert addAction:action];
        }
    }
}
@end
