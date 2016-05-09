//
//  MBProgressHUD+Add.h
//  cloudTop
//
//  Created by idiot.lin on 15/7/15.
//  Copyright (c) 2015年 idiot.lin. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
/**
 * 显示失败信息(单张静态错误提示图)
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;
/**
 * 显示成功信息(单张静态成功提示图)
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
/**
 * 显示信息(单张静态提示图)
 */
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

/**
 * 显示动态加载图
 */
+(void)showHUD:(NSString *)text toView:(UIView *)view;
/**
 * 隐藏动态加载图
 */
+(void)hiddenHUDFromView;
/**
 *  显示成功按钮
 */
+ (void)showCompleteTitle:(NSString *)title ToView:(UIView *)view;

+ (void)showAnimationLoadingWithTitle:(NSString *)title toView:(UIView *)view;
@end
