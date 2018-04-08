//
//  UIView+sg_Convenient.m
//  拓展生成工程
//
//  Created by sylphghost on 15/11/10.
//  Copyright © 2015年 sylphghost. All rights reserved.
//

#import "UIView+SGConvenient.h"

@implementation UIView (SGConvenient)
- (CGFloat)left{
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left{
    CGRect frame=self.frame;
    frame.origin.x=left;
    self.frame=frame;
}


- (CGFloat)top{
    return self.frame.origin.y;

}
- (void)setTop:(CGFloat)top{
    CGRect frame=self.frame;
    frame.origin.y=top;
}


- (CGFloat)right{
    CGRect frame=self.frame;
    return frame.origin.x+frame.size.width;
}
- (void)setRight:(CGFloat)right{
    CGRect frame=self.frame;
    frame.origin.x=right-frame.size.width;
    self.frame=frame;
}

- (CGFloat)bottom{
  
    return self.frame.origin.y+self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom{
    CGRect frame=self.frame;
    frame.origin.y=bottom-frame.size.height;
    self.frame=frame;
}

- (CGFloat)width{

    return self.frame.size.width;

}
- (void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;

}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}

- (CGFloat)centerY{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

- (CGSize)size{

    return  self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}




@end
