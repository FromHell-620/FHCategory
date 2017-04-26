//
//  NSArray+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FHExtend)

- (id)fh_randomObject;

- (NSData*)fh_jsonDataValue;

- (NSString*)fh_jsonStringValue;

- (NSMutableArray*)fh_mutableValue;

- (void)fh_enum:(void(^)(NSInteger idx,id object))block;

- (void)fh_enumWithIgnoreValue:(id)v b:(void(^)(NSInteger idx,id object))block;

- (NSArray*)fh_filter:(BOOL(^)(id obj))block;

- (void)fh_times:(NSInteger)times block:(void (^)(id obj))block;

- (void)fh_timeMatch:(BOOL (^)(id obj))match if:(BOOL(^)())ifx;

- (void)fh_timeMatch:(BOOL (^)(id obj))match else:(BOOL(^)())elsex;

- (void)fh_timeMatch:(BOOL (^)(id obj))match if:(BOOL(^)())ifx else:(BOOL(^)())elsex;

- (void)fh_timesMatch:(BOOL (^)(id obj))match if:(BOOL(^)(NSInteger idx,id object))ifx;

- (void)fh_timesMatch:(BOOL (^)(id obj))match else:(BOOL(^)(NSInteger idx,id object))elsex;

- (void)fh_timesMatch:(BOOL (^)(id obj))match if:(BOOL(^)(NSInteger idx,id object))ifx else:(BOOL(^)(NSInteger idx,id object))elsex;

@end
