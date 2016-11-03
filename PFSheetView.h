//
//  PFSheetView.h
//  SheetView
//
//  Created by ekhome on 16/11/1.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//引入UIkit框架的原因是方法参数适用到了UI控件
@protocol PFSheetViewDelegate;
@interface PFSheetView : NSObject
//来个代理
@property (nonatomic,weak)id <PFSheetViewDelegate> delegate;

//ActionTitle数组
@property (nonatomic,strong)NSArray <NSString *> *actionTitles;

//构造方法
-(instancetype)initWithTitle:(NSString *)title andMeaasge:(NSString *)massage;

//跳转展示方法
-(void)showWityController:(UIViewController *)controller;
@end

@protocol PFSheetViewDelegate <NSObject>

@optional//非必须实现的方法
-(UIAlertActionStyle)sheetView:(PFSheetView *)sheetViwe actionStyleAtIndex:(NSInteger)index;

//点击对应的Action 之后触发的方法
-(void)sheetView:(PFSheetView *)sheetView didSelectAtIndex:(NSInteger)index;

@end