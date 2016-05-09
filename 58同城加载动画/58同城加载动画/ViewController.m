//
//  ViewController.m
//  58同城加载动画
//
//  Created by sylphghost on 16/1/6.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "ViewController.h"
#import "SGLoadingAnimatingView.h"
#import "SGLoadingAnimatingView.h"
#import "UIView+sg_Convenient.h"
#import "MBProgressHUD+Add.h"
 NSString *const text=@"asdads";
@interface ViewController ()

@property(strong,nonatomic) SGLoadingAnimatingView *loadingV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //  NSLog(@"%@",text);
    [MBProgressHUD showAnimationLoadingWithTitle:@"加载中..." toView:self.view];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem=rightItem;
//    SGLoadingAnimatingView *animation=[SGLoadingAnimatingView new];
//    _loadingV=animation;
//    animation.centerX=self.view.width/2;
//    animation.centerY=self.view.height/2;
//   // animation.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:animation];
//    [animation startAnimating];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MBProgressHUD showAnimationLoadingWithTitle:@"加载中..." toView:self.view];
}
- (void)rightButton:(UIBarButtonItem *)sender{
    [MBProgressHUD hideHUDForView:self.view animated:YES];


}
@end
