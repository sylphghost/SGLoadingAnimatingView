//
//  SGLoadingAnimatingView.h
//  58同城加载动画
//
//  Created by sylphghost on 16/1/6.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SGLoadingAnimatingView : UIView
/**
 *  开始动画
 */
- (void)startAnimating;
/**
 *  停止动画
 */
- (void)stopAniamting;

@end
@protocol SGLoadingAnimatingViewHelperDelegate  <NSObject>
@optional
- (void)helperAnimationDidStart:(CAAnimation *)anim;
- (void)helperAnimationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end

@interface SGLoadingAnimatingViewHelper : NSObject
/**
 *  动画代理
 */
@property(weak,nonatomic) id<SGLoadingAnimatingViewHelperDelegate>delegate;
@end