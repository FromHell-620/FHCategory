//
//  UIImage+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/5/1.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FHExtend)

+ (UIImage*)fh_imageWithColor:(UIColor*)color;

+ (UIImage*)fh_imageWithColor:(UIColor*)color size:(CGSize)size;

- (NSData*)fh_zipToData;

- (NSData*)fh_zipToDataWithQuality:(CGFloat)quality;

@end
