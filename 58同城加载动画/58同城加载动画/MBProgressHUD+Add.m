//
//  MBProgressHUD+CTExtension.m
//  cloudTop
//
//  Created by idiot.lin on 15/7/15.
//  Copyright (c) 2015年 idiot.lin. All rights reserved.
//

#import "MBProgressHUD+Add.h"
#import "SGLoadingAnimatingView.h"
@implementation MBProgressHUD (Add)


+(void)show:(NSString *)text imageName:(NSString*)imageName AndCount:(int)count view:(UIView *)view
{
    if (view==nil) view = [UIApplication sharedApplication].keyWindow;
    //快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    //创建动态图片
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1; i<count; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%@%d",imageName,i];
        UIImage *imag = [UIImage imageNamed:name];
        [imageArr addObject:imag];
    }
    imageV.animationImages = imageArr;
    imageV.animationDuration = 1.0;
    [imageV startAnimating];
    //赋值给custonView
    hud.customView = imageV;
    hud.color = [UIColor grayColor];
    //设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
}




+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor grayColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0f];
}


#pragma mark 显示动态图片
+(void)showHUD:(NSString *)text toView:(UIView *)view
{
    [self show:text imageName:@"jiazai" AndCount:24 view:view];
}

+(void)hiddenHUDFromView
{
    MBProgressHUD *hud = [self HUDForView:[UIApplication sharedApplication].keyWindow];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    }
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.color = [UIColor grayColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}
+ (void)showCompleteTitle:(NSString *)title ToView:(UIView *)view{
  if (view == nil) view = [UIApplication sharedApplication].keyWindow;
  MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.animationType=MBProgressHUDAnimationFade;
    HUD.labelText =title;
    HUD.color=[UIColor grayColor];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.2];

}
+ (void)showAnimationLoadingWithTitle:(NSString *)title toView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    SGLoadingAnimatingView *loadingVieew=[SGLoadingAnimatingView new];
    HUD.customView = loadingVieew;
    [loadingVieew startAnimating];
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.animationType=MBProgressHUDAnimationFade;
    HUD.color=[UIColor clearColor];
    HUD.labelText =title;
    HUD.labelFont=[UIFont systemFontOfSize:13];
    HUD.labelColor=[UIColor grayColor];
    [HUD show:YES];
}

@end
