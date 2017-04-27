//
//  UIView+CNKit.m
//  SalesAssistantApp
//
//  Created by xyt on 15/1/13.
//  Copyright (c) 2015年 好居. All rights reserved.
//

#import "UIView+CNKit.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (CNKit)
@dynamic info_Dict,description;

static const void *IndieBandNameKey = &IndieBandNameKey;
static const void *DescriptionKey = &DescriptionKey;

#pragma mark view转换成Image
-(UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark 切换效果
-(void)switchContentViewWithAnimation:(NSString *)direction {
    [self switchContentViewWithAnimation:direction type:kCATransitionPush duration:0.3f];
}
-(void)switchContentViewWithAnimation:(NSString *)direction type:(NSString *)transitionType {
    [self switchContentViewWithAnimation:direction type:transitionType duration:0.3f];
}
-(void)switchContentViewWithAnimation:(NSString *)direction type:(NSString *)transitionType duration:(float)duration {
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = duration;
    //先慢后快
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = direction;
    animation.removedOnCompletion = NO;
    //各种组合
    animation.type = transitionType;
    animation.subtype = direction;
    
    [self.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark 设置view的宽度的set方法
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

#pragma mark 设置view的宽度的get方法
- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark 设置view的高度的set方法
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark 设置view的高度的get方法
- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark 设置view的X值的set方法
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

#pragma mark 设置view的X值的get方法
- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark 设置view的y值的set方法
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

#pragma mark 设置view的y值的get方法
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    bottom = bottom;
}
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {

  self.center = CGPointMake(centerX,self.centerY);

}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
  self.center = CGPointMake(self.centerX, centerY);
}
#pragma mark 点击事件
- (void)addActionWithTarget:(id)target action:(SEL)selector {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark 详细属性设置
-(void)setInfo_Dict:(NSDictionary *)info_Dict {
    objc_setAssociatedObject(self, IndieBandNameKey, info_Dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)info_Dict {
    return objc_getAssociatedObject(self, IndieBandNameKey);
}

#pragma mark 描述
-(void)setDescription:(NSString *)description {
    objc_setAssociatedObject(self, DescriptionKey, description, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)description {
    return objc_getAssociatedObject(self, DescriptionKey);
}

@end
