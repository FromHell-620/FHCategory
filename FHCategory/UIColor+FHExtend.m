//
//  UIColor+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/8/1.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "UIColor+FHExtend.h"

@implementation UIColor (FHExtend)

+ (UIColor *)fh_hexColor:(UInt32)col {
    return [self fh_hexColor:col alpha:100];
}

+ (UIColor *)fh_hexColor:(UInt32)col alpha:(CGFloat)alpha {
    uint32_t x = 0xff;
    unsigned char r,g,b;
    b = x & col;
    g = x & (col >> 8);
    r = x & (col >> 16);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha/100.0];
}

+ (UIColor *)fh_hexColorWithString:(NSString *)str {
    return [self fh_hexColorWithString:str alpha:100];
}

+ (UIColor *)fh_hexColorWithString:(NSString *)str alpha:(CGFloat)alpha {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor fh_hexColor:(UInt32)x alpha:alpha];
}

@end
