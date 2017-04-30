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
    return [self fh_zipToDataWithQuotient:1.f];
}

- (NSData*)fh_zipToDataWithQuality:(CGFloat)quality {
    return UIImageJPEGRepresentation(self, quality);
}

@end
