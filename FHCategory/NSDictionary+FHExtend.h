//
//  NSDictionary+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/30.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FHExtend)

- (id)fh_randomKey;

- (id)fh_randomValue;

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)())ifx;

- (void)fh_timeMatch:(BOOL (^)(id key,id obj))match
                else:(BOOL(^)())elsex;

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)())ifx
                else:(BOOL(^)())elsex;

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                   if:(BOOL(^)(id key,id obj))ifx;

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                 else:(BOOL(^)(id key,id obj))elsex;

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                   if:(BOOL(^)(id key,id obj))ifx
                 else:(BOOL(^)(id key ,id obj))elsex;

@end
