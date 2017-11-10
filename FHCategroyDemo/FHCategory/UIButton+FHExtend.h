//
//  UIButton+FHExtend.h
//  FHCategroyDemo
//
//  Created by imac on 2017/11/10.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FHButtonEdgeInsetsStyle) {
    FHButtonEdgeInsetsStyleTop,
    FHButtonEdgeInsetsStyleLeft,
    FHButtonEdgeInsetsStyleRight,
    FHButtonEdgeInsetsStyleButtom
};

@interface UIButton (FHExtend)

- (void)setEdgeInsetsStyle:(FHButtonEdgeInsetsStyle)style space:(CGFloat)space;

@end
