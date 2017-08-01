//
//  UIColor+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/8/1.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FHExtend)

+ (UIColor *)fh_hexColor:(UInt32)col;

+ (UIColor *)fh_hexColor:(UInt32)col alpha:(CGFloat)alpha;

+ (UIColor *)fh_hexColorWithString:(NSString *)str;

+ (UIColor *)fh_hexColorWithString:(NSString *)str alpha:(CGFloat)alpha;

@end
