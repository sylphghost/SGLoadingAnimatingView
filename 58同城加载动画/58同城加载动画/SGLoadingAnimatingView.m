//
//  SGLoadingAnimatingView.m
//  58同城加载动画
//
//  Created by sylphghost on 16/1/6.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "SGLoadingAnimatingView.h"
#import "UIView+sg_Convenient.h"
static const CGFloat kDeformationLayerWidthAndHeight = 25;
static const CGFloat kViewDefaultWidth = 60;
static const CGFloat kViewDefaultHeight = 90;
static const CGFloat kBottomShadowHeight = 3;
static const CGFloat kAniamtionPer = 0.85;
static NSTimeInterval kFallAniamtionTime = 0.38;
static NSTimeInterval kJumpAniamtionTime = 0.43;


#define kSquareTypeColor \
  [UIColor colorWithRed:0.872 green:0.2462 blue:0.2012 alpha:1.0].CGColor
#define kCircleTypeColor \
  [UIColor colorWithRed:0.2646 green:0.4433 blue:0.9396 alpha:1.0].CGColor
#define ktriangleTypeColor \
  [UIColor colorWithRed:0.1665 green:0.7737 blue:0.3759 alpha:1.0].CGColor
#define kShadowDeepColor \
  [UIColor colorWithRed:0.4484 green:0.4484 blue:0.4484 alpha:1.0].CGColor
#define kShadowLowColor \
  [UIColor colorWithRed:0.7699 green:0.7699 blue:0.7699 alpha:1.0].CGColor
@interface SGLoadingAnimatingView ()<SGLoadingAnimatingViewHelperDelegate>
/**
 *  形变Layer
 */
@property(strong, nonatomic) CALayer* deformationLayer;
/**
 *  运动上点
 */
@property(assign, nonatomic) CGPoint fallStartPoint;

/**
 * 运动下点
 */
@property(assign, nonatomic) CGPoint fallStopPoint;

/**
 *  判断此时的状态
 */
@property(assign, nonatomic) NSInteger step;

/**
 *  之前的旋转状态
 */
@property(assign, nonatomic) CGFloat oldAngule;
/**
 *  遮罩层
 */
@property(strong, nonatomic) UIBezierPath* oldPath;
/**
 *  阴影层
 */
@property(strong, nonatomic) CALayer* bottomShadowLayer;

/**
 *  是否正在运行
 */
@property(assign, nonatomic, getter=isAnimating) BOOL animating;
/**
 *
 */
@property(strong,nonatomic) SGLoadingAnimatingViewHelper *loadingViewHelper;
@end
@implementation SGLoadingAnimatingView
#pragma mark - life cycle
- (instancetype)initWithCoder:(NSCoder*)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self initializationWithFrame:CGRectZero];
  }
  return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self initializationWithFrame:frame];
  }
  return self;
}
- (instancetype)init {
  if (self = [super init]) {
    [self initializationWithFrame:CGRectZero];
  }
  return self;
}
- (void)dealloc{
    NSLog(@"loadingView加载停止了");

}
#pragma mark - Delegate
#pragma  mark SGLoadingAnimatingViewHelperDelegate
- (void)helperAnimationDidStart:(CAAnimation *)anim{


}
- (void)helperAnimationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [_deformationLayer animationForKey:@"fallAniamtion"]) {
        if (_step == 4)
            _step = 0;
        [self deformationLayerJumpFromPoint:_fallStopPoint
                                    ToPoint:_fallStartPoint
                                   WithStep:_step];
        _step++;
    }
    if (anim == [_deformationLayer animationForKey:@"jumpGroupAnimation"]) {
        [self deformationLayerFallFromPoint:_fallStartPoint toPoint:_fallStopPoint];
    }

}
#pragma mark - event response
#pragma mark - private method
- (void)startAnimating {
  if (_animating) {
    return;
  }
  _animating = YES;
  [self deformationLayerJumpFromPoint:_fallStopPoint
                              ToPoint:_fallStartPoint
                             WithStep:_step];
  _step++;
}
- (void)stopAniamting {
  _animating = NO;
    [_deformationLayer removeAllAnimations];
}
- (void)initializationWithFrame:(CGRect)frame {
    NSLog(@"%@",text);
    _loadingViewHelper=[SGLoadingAnimatingViewHelper new];
    _loadingViewHelper.delegate=self;
    
  _deformationLayer = [CALayer layer];
  [self.layer addSublayer:_deformationLayer];
  self.width = self.width < kViewDefaultWidth ? kViewDefaultWidth : self.width;
  self.height =
      self.height < kViewDefaultHeight ? kViewDefaultHeight : self.height;

  _deformationLayer.frame = CGRectMake(0, 0, kDeformationLayerWidthAndHeight,
                                       kDeformationLayerWidthAndHeight);
  _fallStartPoint =
      CGPointMake(self.width / 2.0, kDeformationLayerWidthAndHeight);
  _fallStopPoint = CGPointMake(self.width / 2.0,
                               self.height - kDeformationLayerWidthAndHeight);
  _deformationLayer.position = _fallStopPoint;
  _deformationLayer.shouldRasterize = YES;
  _deformationLayer.shadowOpacity = 0.01;
  _oldAngule = 0;
  _oldPath = [UIBezierPath
      bezierPathWithRect:CGRectMake(0, 0, kDeformationLayerWidthAndHeight,
                                    kDeformationLayerWidthAndHeight)];
  CAShapeLayer* maskLayer = [CAShapeLayer layer];
  _deformationLayer.mask = maskLayer;
  maskLayer.path = _oldPath.CGPath;

  _bottomShadowLayer = [CALayer layer];
  [self.layer addSublayer:_bottomShadowLayer];
  _bottomShadowLayer.frame =
      CGRectMake(_deformationLayer.frame.origin.x,
                 _deformationLayer.frame.origin.y + kBottomShadowHeight +
                     kDeformationLayerWidthAndHeight,
                 kDeformationLayerWidthAndHeight, kBottomShadowHeight);
  CAShapeLayer* bottomShadowShapeLayer = [CAShapeLayer layer];
  bottomShadowShapeLayer.path =
      [UIBezierPath bezierPathWithOvalInRect:_bottomShadowLayer.bounds].CGPath;
  _bottomShadowLayer.mask = bottomShadowShapeLayer;
}

- (void)deformationLayerFallFromPoint:(CGPoint)startPoint
                              toPoint:(CGPoint)endPoint {
  CABasicAnimation* fallAniamtion =
      [CABasicAnimation animationWithKeyPath:@"position"];
  fallAniamtion.fromValue = [NSValue valueWithCGPoint:startPoint];
  fallAniamtion.toValue = [NSValue valueWithCGPoint:endPoint];
  CAMediaTimingFunction* fallTimeFucntion =
      [CAMediaTimingFunction functionWithControlPoints:0.44:0.01:0.75:0.6];
  fallAniamtion.timingFunction = fallTimeFucntion;
  fallAniamtion.removedOnCompletion = NO;
  fallAniamtion.fillMode = kCAFillModeForwards;

  CGFloat rotationAngule = 0;
  switch (_step) {
    case 1:
      rotationAngule = M_PI;
      break;
    case 2:
      rotationAngule = 0;
    case 3:
      rotationAngule = -2 / 3.0 * M_PI;
      break;
    case 4:
      rotationAngule = 0;
    default:

      break;
  }
  CABasicAnimation* rotationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.timingFunction =
      [CAMediaTimingFunction functionWithControlPoints:0.44:0.01:0.75:0.6];
  rotationAnimation.fromValue = @(_oldAngule);
  rotationAnimation.toValue = @(rotationAngule);
  CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
  animationGroup.animations = @[ rotationAnimation, fallAniamtion ];
  animationGroup.fillMode = kCAFillModeForwards;
  animationGroup.removedOnCompletion = NO;
  animationGroup.duration = kFallAniamtionTime;
  animationGroup.delegate = _loadingViewHelper;
  [_deformationLayer addAnimation:animationGroup forKey:@"fallAniamtion"];
  _oldAngule = 0;
  [self bottomShapeAnimationFromRect:CGRectMake(
                                         kDeformationLayerWidthAndHeight / 2 -
                                             kBottomShadowHeight / 2,
                                         0, kBottomShadowHeight,
                                         kBottomShadowHeight)
                              ToRect:CGRectMake(0, 0,
                                                kDeformationLayerWidthAndHeight,
                                                kBottomShadowHeight)
                            WithTime:kFallAniamtionTime
                     AndTimeFunction:fallTimeFucntion];
}
- (void)deformationLayerJumpFromPoint:(CGPoint)startPoint
                              ToPoint:(CGPoint)endPoint
                             WithStep:(NSInteger)step {
  CABasicAnimation* jumpAniamtion =
      [CABasicAnimation animationWithKeyPath:@"position"];
  jumpAniamtion.fromValue = [NSValue valueWithCGPoint:startPoint];
  jumpAniamtion.toValue = [NSValue valueWithCGPoint:endPoint];
  CAMediaTimingFunction* jumpTimeFunction =
      [CAMediaTimingFunction functionWithControlPoints:0.29:0.45:0.54:0.99];
  jumpAniamtion.timingFunction = jumpTimeFunction;

  CGFloat rotationAngule = 0;
  UIBezierPath* maskPath = [UIBezierPath bezierPath];
  CAShapeLayer* maskLayer = (CAShapeLayer*)_deformationLayer.mask;

  switch (step) {
    case 0: {
      rotationAngule = kAniamtionPer * M_PI;
      _deformationLayer.backgroundColor = kSquareTypeColor;
      maskPath = [UIBezierPath
          bezierPathWithRect:CGRectMake(0, 0, kDeformationLayerWidthAndHeight,
                                        kDeformationLayerWidthAndHeight)];
    } break;
    case 1: {
      rotationAngule = 0;
      _deformationLayer.backgroundColor = kCircleTypeColor;
      maskPath = [UIBezierPath
          bezierPathWithOvalInRect:CGRectMake(0, 0,
                                              kDeformationLayerWidthAndHeight,
                                              kDeformationLayerWidthAndHeight)];
    }

    break;
    case 2: {
      rotationAngule = -2 / 3.0 * M_PI * kAniamtionPer;
      _deformationLayer.backgroundColor = ktriangleTypeColor;
      [maskPath moveToPoint:CGPointMake(kDeformationLayerWidthAndHeight / 2.0,
                                        (1 - sqrt(3) / 2.0) *
                                            kDeformationLayerWidthAndHeight)];
      [maskPath addLineToPoint:CGPointMake(0, kDeformationLayerWidthAndHeight)];
      [maskPath addLineToPoint:CGPointMake(kDeformationLayerWidthAndHeight,
                                           kDeformationLayerWidthAndHeight)];
      [maskPath closePath];

    } break;
    case 3: {
      rotationAngule = 0;
      _deformationLayer.backgroundColor = kCircleTypeColor;
      maskPath = [UIBezierPath
          bezierPathWithOvalInRect:CGRectMake(0, 0,
                                              kDeformationLayerWidthAndHeight,
                                              kDeformationLayerWidthAndHeight)];
    }

    break;
    default:

      break;
  }

  maskLayer.path = maskPath.CGPath;

  CABasicAnimation* rotationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.timingFunction =
      [CAMediaTimingFunction functionWithControlPoints:0:0.11:0.:0.39];
  rotationAnimation.fromValue = @(_oldAngule);
  rotationAnimation.toValue = @(rotationAngule);

  _oldAngule = rotationAngule;
  _oldPath = maskPath;

  CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
  animationGroup.animations = @[ rotationAnimation, jumpAniamtion ];
  animationGroup.fillMode = kCAFillModeForwards;
  animationGroup.removedOnCompletion = NO;
  animationGroup.duration = kJumpAniamtionTime;
  animationGroup.delegate = _loadingViewHelper;
  [_deformationLayer addAnimation:animationGroup forKey:@"jumpGroupAnimation"];

  [self bottomShapeAnimationFromRect:CGRectMake(0, 0,
                                                kDeformationLayerWidthAndHeight,
                                                kBottomShadowHeight)
                              ToRect:CGRectMake(
                                         kDeformationLayerWidthAndHeight / 2 -
                                             kBottomShadowHeight / 2,
                                         0, kBottomShadowHeight,
                                         kBottomShadowHeight)
                            WithTime:kJumpAniamtionTime
                     AndTimeFunction:jumpTimeFunction];
}
- (void)bottomShapeAnimationFromRect:(CGRect)fromRect
                              ToRect:(CGRect)toRect
                            WithTime:(CFTimeInterval)duration
                     AndTimeFunction:(CAMediaTimingFunction*)timeFunction {
  CAShapeLayer* bottomShaperLayer = (CAShapeLayer*)_bottomShadowLayer.mask;

  CABasicAnimation* rectAniamtion =
      [CABasicAnimation animationWithKeyPath:@"path"];
  rectAniamtion.fromValue =
      (__bridge id)[UIBezierPath bezierPathWithOvalInRect:fromRect].CGPath;
  rectAniamtion.toValue =
      (__bridge id)[UIBezierPath bezierPathWithOvalInRect:toRect].CGPath;
  rectAniamtion.timingFunction = timeFunction;
  rectAniamtion.duration = duration;
  rectAniamtion.removedOnCompletion = NO;
  rectAniamtion.fillMode = kCAFillModeForwards;
  [bottomShaperLayer addAnimation:rectAniamtion forKey:@"rectAniamtion"];

  CABasicAnimation* colorAniamtion =
      [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
  colorAniamtion.fromValue = fromRect.size.width > toRect.size.width
                                 ? (__bridge id)kShadowDeepColor
                                 : (__bridge id)kShadowLowColor;
  colorAniamtion.toValue = fromRect.size.width > toRect.size.width
                               ? (__bridge id)kShadowLowColor
                               : (__bridge id)kShadowDeepColor;

  colorAniamtion.timingFunction = timeFunction;
  colorAniamtion.duration = duration;
  colorAniamtion.removedOnCompletion = NO;
  colorAniamtion.fillMode = kCAFillModeForwards;

  [_bottomShadowLayer addAnimation:colorAniamtion forKey:@"colorAniamtion"];
    
}
#pragma mark - getters and setters


@end


@implementation SGLoadingAnimatingViewHelper
- (void)dealloc{

    NSLog(@"helper消失了");

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)animationDidStart:(CAAnimation *)anim{
    if ([_delegate respondsToSelector:@selector(helperAnimationDidStart:)]) {
        [_delegate helperAnimationDidStart:anim];
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([_delegate respondsToSelector:@selector(helperAnimationDidStop:finished:)]) {
        [_delegate helperAnimationDidStop:anim finished:flag];
    }

}
@end