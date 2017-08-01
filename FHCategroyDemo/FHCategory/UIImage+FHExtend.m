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

- (UIImage *)fh_imageResizeing:(UIEdgeInsets)insets {
    return [self fh_imageResizeing:insets mode:UIImageResizingModeStretch];
}

- (UIImage *)fh_imageResizeing:(UIEdgeInsets)insets mode:(UIImageResizingMode)mode {
    return [self resizableImageWithCapInsets:insets resizingMode:mode];
}

- (UIImage*)fh_fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
