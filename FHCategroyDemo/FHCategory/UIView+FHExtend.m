//
//  UIView+FHExtend.m
//  FHCategroyDemo
//
//  Created by xyt on 2017/4/27.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "UIView+FHExtend.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (FHExtend)

- (void)fh_setX:(CGFloat)fh_x {
    CGRect frame = self.frame;
    frame.origin.x = fh_x;
    self.frame = frame;
}

- (CGFloat)fh_X {
    return self.frame.origin.x;
}

- (void)fh_setY:(CGFloat)fh_y {
    CGRect frame = self.frame;
    frame.origin.y = fh_y;
    self.frame = frame;
}

- (CGFloat)fh_Y {
    return self.frame.origin.y;
}

- (void)fh_setWidth:(CGFloat)fh_width {
    CGRect frame = self.frame;
    frame.size.width = fh_width;
    self.frame = frame;
}

- (CGFloat)fh_Width {
    return self.frame.size.width;
}

- (void)fh_setHeight:(CGFloat)fh_height {
    CGRect frame = self.frame;
    frame.size.height = fh_height;
    self.frame = frame;
}

- (CGFloat)fh_Height {
    return self.frame.size.height;
}

- (void)fh_setCenterX:(CGFloat)fh_centerX {
    CGPoint point = self.center;
    point.x = fh_centerX;
    self.center = point;
}

- (CGFloat)fh_CenterX {
    return self.center.x;
}

- (void)fh_setCenterY:(CGFloat)fh_centerY {
    CGPoint point = self.center;
    point.y = fh_centerY;
    self.center = point;
}

- (CGFloat)fh_CenterY {
    return self.center.y;
}

- (void)fh_setCornerRadius:(CGFloat)fh_cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = fh_cornerRadius;
}

- (CGFloat)fh_CornerRadius {
    return self.layer.cornerRadius;
}

- (void)fh_setImage:(UIImage *)fh_image {
    self.layer.contents = (__bridge id _Nullable)(fh_image.CGImage);
}

- (UIImage*)fh_Image {
    return [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(self.layer.contents)];
}

- (void)fh_removeAllSubviews {
    for (UIView* subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (UIViewController*)fh_controller {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIImage*)fh_imageify {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
