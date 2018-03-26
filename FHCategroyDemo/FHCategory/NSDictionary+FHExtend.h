//
//  NSDictionary+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/30.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType,ObjectType> (FHExtend)

- (KeyType)fh_randomKey;

- (ObjectType)fh_randomValue;

- (void)fh_enmu:(void(^)(KeyType key,ObjectType value))block;

- (void)fh_timeMatch:(BOOL(^)(KeyType key,ObjectType obj))match
                  if:(BOOL(^)(void))ifx;

- (void)fh_timeMatch:(BOOL (^)(KeyType key,ObjectType obj))match
                else:(BOOL(^)(void))elsex;

- (void)fh_timeMatch:(BOOL(^)(KeyType key,ObjectType obj))match
                  if:(BOOL(^)(void))ifx
                else:(BOOL(^)(void))elsex;

- (void)fh_timesMatch:(BOOL(^)(KeyType key,ObjectType obj))match
                   if:(BOOL(^)(KeyType key,ObjectType obj))ifx;

- (void)fh_timesMatch:(BOOL(^)(KeyType key,ObjectType obj))match
                 else:(BOOL(^)(KeyType key,ObjectType obj))elsex;

- (void)fh_timesMatch:(BOOL(^)(KeyType key,ObjectType obj))match
                   if:(BOOL(^)(KeyType key,ObjectType obj))ifx
                 else:(BOOL(^)(KeyType key ,ObjectType obj))elsex;

- (NSDictionary<KeyType,ObjectType>*)fh_filter:(BOOL(^)(KeyType key,ObjectType obj))block;

- (NSDictionary*)fh_map:(id(^)(KeyType key,ObjectType obj))block;

- (NSDictionary*)fh_filterMap:(id(^)(KeyType key,ObjectType obj,BOOL* filter))block;

@end

@interface NSMutableDictionary<KeyType,ObjectType> (FHExtend)

- (void)fh_filter:(BOOL(^)(KeyType key,ObjectType obj))block;

- (void)fh_map:(id(^)(KeyType key,ObjectType obj))block;

- (void)fh_filterMap:(id(^)(KeyType key,ObjectType obj,BOOL* filter))block;

@end
