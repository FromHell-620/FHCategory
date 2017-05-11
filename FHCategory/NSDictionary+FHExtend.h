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

- (void)fh_enmu:(void(^)(id key,id value))block;

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

- (NSDictionary*)fh_filter:(BOOL(^)(id key,id obj))block;

- (NSDictionary*)fh_map:(id(^)(id key,id obj))block;

- (NSDictionary*)fh_filterMap:(id(^)(id key,id obj,BOOL* filter))block;

@end

@interface NSMutableDictionary (FHExtend)

- (void)fh_filter:(BOOL(^)(id key,id obj))block;

- (void)fh_map:(id(^)(id key,id obj))block;

- (void)fh_filterMap:(id(^)(id key,id obj,BOOL* filter))block;

@end
