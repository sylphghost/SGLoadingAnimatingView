//
//  MBProgressHUD+CTExtension.m
//  cloudTop
//
//  Created by idiot.lin on 15/7/15.
//  Copyright (c) 2015年 idiot.lin. All rights reserved.
//

#import "MBProgressHUD+Add.h"
#import "SGLoadingAnimatingView/SGLoadingAnimatingView.h"
@implementation MBProgressHUD (Add)
+ (void)showAnimationLoadingWithTitle:(NSString *)title toView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    SGLoadingAnimatingView *loadingView=[SGLoadingAnimatingView new];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:loadingView.width];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:loadingView.height];
    
    [loadingView addConstraint:widthConstraint];
    [loadingView addConstraint:heightConstraint];
    hud.customView = loadingView;
    hud.animationType=MBProgressHUDAnimationFade;
    hud.bezelView.color = [UIColor clearColor];
    hud.label.text =title;
    hud.label.font=[UIFont systemFontOfSize:13];
    hud.label.textColor=[UIColor grayColor];
    [loadingView startAnimating];

    
    [hud showAnimated:YES];
}

@end
