//
//  ViewController.m
//  58同城加载动画
//
//  Created by sylphghost on 16/1/6.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "ViewController.h"
#import <SGLoadingAnimatingView/SGLoadingAnimatingView.h>
#import "MBProgressHUD+Add.h"
 NSString *const text=@"asdads";
@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"remove" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    
    self.navigationItem.rightBarButtonItem=rightItem;
    self.navigationItem.leftBarButtonItem=leftItem;
    self.title = @"SGLoadingAnimatingView";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
    // Dispose of any resources that can be recreated.
}
- (void)leftButtonAction:(UIBarButtonItem *)senderr{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showAnimationLoadingWithTitle:@"加载中..." toView:self.view];
}
- (void)rightButtonAction:(UIBarButtonItem *)sender{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
