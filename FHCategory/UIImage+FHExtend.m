//
//  UIImage+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/5/1.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "UIImage+FHExtend.h"

@implementation UIImage (FHExtend)

+ (UIImage*)fh_imageWithColor:(UIColor*)color {
    return [self fh_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage*)fh_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData*)fh_zipToData {
    return [self fh_zipToDataWithQuality:1.f];
}

- (NSData*)fh_zipToDataWithQuality:(CGFloat)quality {
    return UIImageJPEGRepresentation(self, quality);
}

- (UIImage*)fh_imageWithTintColor:(UIColor *)tintColor {
    return [self fh_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage*)fh_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    UIGraphicsBeginImageContext(self.size);
    [tintColor setFill];
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(rect);
    [self drawAtPoint:CGPointZero blendMode:blendMode alpha:1];
    UIImage* new_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new_image;
}

- (UIImage*)fh_imageByResize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* new_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new_image;
}

- (UIImage*)fh_imageByCropSize:(CGSize)size {
    size.width = size.width>self.size.width?self.size.width:size.width;
    size.height = size.height>self.size.height?self.size.height:size.height;
    CGRect rect = CGRectMake((self.size.width-size.width)/2.f, (self.size.height-size.height)/2.f, size.width, size.height);
    return [self fh_imageByCropRect:rect];
}

- (UIImage*)fh_imageByCropRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* new_image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return new_image;
}

@end
