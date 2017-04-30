//
//  UIView+FHExtend.h
//  FHCategroyDemo
//
//  Created by xyt on 2017/4/27.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FHExtend)

#pragma mark- Property
@property (nonatomic,assign,setter=fh_setX:,getter=fh_X) CGFloat fh_x;

@property (nonatomic,assign,setter=fh_setY:,getter=fh_Y) CGFloat fh_y;

@property (nonatomic,assign,setter=fh_setWidth:,getter=fh_Width) CGFloat fh_width;

@property (nonatomic,assign,setter=fh_setHeight:,getter=fh_Height) CGFloat fh_height;

@property (nonatomic,assign,setter=fh_setCenterX:,getter=fh_CenterX) CGFloat fh_centerX;

@property (nonatomic,assign,setter=fh_setCenterY:,getter=fh_CenterY) CGFloat fh_centerY;

@property (nonatomic,assign,setter=fh_setCornerRadius:,getter=fh_CornerRadius) CGFloat fh_cornerRadius;

@property (nonatomic,strong,setter=fh_setImage:,getter=fh_Image) UIImage* fh_image;

#pragma marl- Method
- (void)fh_removeAllSubviews;

- (UIViewController*)fh_controller;

- (UIImage*)fh_imageify;

@end


