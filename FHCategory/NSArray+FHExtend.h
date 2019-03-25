//
//  NSArray+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (FHExtend)

- (ObjectType)fh_randomObject;

- (NSArray<NSString *> *)fh_randomArrayWithCount:(NSUInteger)count;

- (NSData *)fh_jsonDataValue;

- (NSString *)fh_jsonStringValue;

- (NSMutableArray<ObjectType> *)fh_mutableValue;

- (NSArray<ObjectType> *)fh_addObject:(ObjectType)obj;

- (NSArray<ObjectType> *)fh_addObjectsFromArray:(NSArray<ObjectType> *)arr;

- (NSArray<ObjectType> *)fh_prependObject:(ObjectType)obj;

- (NSArray<ObjectType> *)fh_prependObjects:(NSArray<ObjectType> *)objs;

- (NSArray<ObjectType> *)fh_insertObject:(ObjectType)obj atIndex:(NSInteger)idx;

- (void)fh_enum:(void(^)(NSInteger idx,ObjectType object))block;

- (void)fh_enumWithIgnoreValue:(ObjectType)v b:(void(^)(NSInteger idx,ObjectType object))block;

- (NSArray<NSArray<ObjectType> *> *)fh_groupingWithCount:(NSInteger)count;

- (NSArray<NSArray<ObjectType> *> *)fh_groupingWithModNumber:(NSInteger)mod;

- (NSArray<ObjectType> *)fh_filter:(BOOL(^)(ObjectType obj))block;

- (void)fh_time:(NSInteger)times
           block:(void (^)(ObjectType obj))block;

- (void)fh_times:(NSInteger)times
           block:(void(^)(ObjectType obj,NSInteger idx))block;

- (void)fh_timeMatch:(BOOL (^)(ObjectType obj))match
                  if:(BOOL(^)(void))ifx;

- (void)fh_timeMatch:(BOOL (^)(ObjectType obj))match
                else:(BOOL(^)(void))elsex;

- (void)fh_timeMatch:(BOOL (^)(ObjectType obj))match
                  if:(BOOL(^)(void))ifx
                else:(BOOL(^)(void))elsex;

- (void)fh_timesMatch:(BOOL (^)(ObjectType obj))match
                   if:(BOOL(^)(NSInteger idx,ObjectType object))ifx;

- (void)fh_timesMatch:(BOOL (^)(ObjectType obj))match
                 else:(BOOL(^)(NSInteger idx,ObjectType object))elsex;

- (void)fh_timesMatch:(BOOL (^)(ObjectType obj))match
                   if:(BOOL(^)(NSInteger idx,ObjectType object))ifx
                 else:(BOOL(^)(NSInteger idx,ObjectType object))elsex;

- (void)fh_timesMatch:(BOOL (^)(ObjectType obj))match
                   if:(BOOL (^)(NSInteger idx,ObjectType object))ifx
              endElse:(dispatch_block_t)endBlock;

- (NSArray *)fh_map:(id(^)(ObjectType obj))block;

- (NSArray *)fh_maps:(id(^)(NSInteger idx,ObjectType obj))block;

- (NSArray *)fh_filterMap:(id(^)(ObjectType obj,BOOL* filter))block;

- (NSArray *)fh_filterMaps:(id(^)(ObjectType obj,BOOL *filter,NSInteger idx))block;

- (NSArray<ObjectType> *)fh_reversalify;

- (NSArray<NSNumber *> *)fh_indexesInOther:(NSArray *)other
                                matchBlock:(BOOL(^)(ObjectType obj,id object))matchBlock;

- (NSString *)fh_stringify;

- (NSString *)fh_stringifyWithSeparator:(NSString *)str;

- (NSArray<ObjectType> *)fh_offset:(NSInteger)offset;

- (NSArray<ObjectType> *)fh_subArrWithRange:(NSRange)aRange;

- (ObjectType)fh_findObject:(BOOL(^)(ObjectType obj))match;

@end

@interface NSMutableArray<ObjectType> (FHExtend)

- (ObjectType)fh_pop;

- (void)fh_prependObject:(ObjectType)anObject;

- (void)fh_filter:(BOOL(^)(ObjectType obj))block;

- (void)fh_map:(id(^)(ObjectType obj))block;

- (void)fh_maps:(id(^)(NSInteger idx,ObjectType obj))block;

- (void)fh_filterMap:(id(^)(ObjectType obj,BOOL* filter))block;

- (void)fh_filterMaps:(id(^)(ObjectType obj,BOOL *filter,NSInteger idx))block;

- (void)fh_reversalify;

- (NSArray<NSNumber *> *)fh_indexesInOther:(NSArray *)other
                                matchBlock:(BOOL(^)(ObjectType obj,id object))matchBlock;

@end
