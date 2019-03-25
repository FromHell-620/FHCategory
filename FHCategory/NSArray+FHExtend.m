//
//  NSArray+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "NSArray+FHExtend.h"
#import "NSNumber+FHExtend.h"
#import "NSData+FHExtend.h"
#import "NSString+FHExtend.h"

@implementation NSArray (FHExtend)

- (id)fh_randomObject {
    return [self objectAtIndex:[NSNumber fh_randomNumber:self.count-1].integerValue];
}

- (NSArray<NSString *> *)fh_randomArrayWithCount:(NSUInteger)count {
    if (count == 0) {
        return NSArray.new;
    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:(NSUInteger)count*1.75];
    do {
        id obj = [self fh_randomObject];
        if (![result containsObject:obj]) {
            [result addObject:obj];
        }
    } while (result.count <= count - 1);
    return [result copy];
}

- (NSData *)fh_jsonDataValue {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    return nil;
}

- (NSString *)fh_jsonStringValue {
    return [[self fh_jsonDataValue] fh_stringValue];
}

- (NSMutableArray *)fh_mutableValue {
    return [NSMutableArray arrayWithArray:self];
}

- (NSArray *)fh_addObject:(id)obj {
    NSParameterAssert(obj);
    return [self fh_addObjectsFromArray:@[obj]];
}

- (NSArray *)fh_addObjectsFromArray:(NSArray *)arr {
    if (arr == nil || arr.count == 0) return self;
    NSMutableArray *new = [self fh_mutableValue];
    [new addObjectsFromArray:arr];
    return [new copy];
}

- (NSArray *)fh_prependObject:(id)obj {
    NSParameterAssert(obj);
    NSMutableArray *new = [self fh_mutableValue];
    [new insertObject:obj atIndex:0];
    return [new copy];
}

- (NSArray *)fh_prependObjects:(NSArray *)objs {
    if (objs == nil || objs.count == 0) return self;
    __block NSArray *result = self;
    [objs enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        result = [result fh_prependObject:obj];
    }];
    return result;
}

- (NSArray *)fh_insertObject:(id)obj atIndex:(NSInteger)idx {
    NSParameterAssert(obj);
    NSMutableArray *new = [NSMutableArray arrayWithArray:self];
    [new insertObject:obj atIndex:idx];
    return [new copy];
}

- (void)fh_enum:(void(^)(NSInteger idx,id object))block {
    NSParameterAssert(block);
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(idx, obj);
    }];
}

- (void)fh_enumWithIgnoreValue:(id)v b:(void(^)(NSInteger idx,id object))block {
    NSParameterAssert(block);
    [self fh_enum:^(NSInteger idx, id object) {
        if (![object isEqual:v]) block(idx,object);
    }];
}

- (NSArray *)fh_groupingWithCount:(NSInteger)count {
    NSMutableArray *new = [NSMutableArray array];
    [self fh_enum:^(NSInteger idx, id object) {
        if (idx % count == 0) {
            NSMutableArray *sub_new = [NSMutableArray array];
            [new  addObject:sub_new];
        }
        NSMutableArray *sub_new = [new objectAtIndex:idx/count];
        [sub_new addObject:object];
    }];
    return [new copy];
}

- (NSArray *)fh_groupingWithModNumber:(NSInteger)mod {
    if (mod == 0) return nil;
    NSMutableArray *new = [NSMutableArray array];
    [self fh_enum:^(NSInteger idx, id object) {
        NSMutableArray *sub_new = new.count <= idx % mod ? nil : [new objectAtIndex:idx % mod];
        if (sub_new == nil) {
            sub_new = [NSMutableArray array];
            [new addObject:sub_new];
        }
        [sub_new addObject:object];
    }];
    return new.copy;
}

- (NSArray *)fh_filter:(BOOL(^)(id obj))block {
    NSMutableArray *new = self.fh_mutableValue;
    [new fh_filter:block];
    return [new copy];
}

- (void)fh_time:(NSInteger)times
           block:(void (^)(id obj))block {
    NSCParameterAssert(block);
    [self fh_times:times block:^(id obj, NSInteger idx) {
        block(obj);
    }];
}

- (void)fh_times:(NSInteger)times
           block:(void(^)(id obj,NSInteger idx))block {
    NSCParameterAssert(block);
    [@(times) fh_times:^(NSInteger idx) {
        if (idx < self.count) block(self[idx],idx);
    }];
}

- (void)fh_timeMatch:(BOOL (^)(id obj))match
                  if:(BOOL(^)(void))ifx {
    [self fh_timeMatch:match
                    if:ifx
                  else:^BOOL{
        return NO;
    }];
}

- (void)fh_timeMatch:(BOOL (^)(id obj))match
                else:(BOOL(^)(void))elsex {
    [self fh_timeMatch:match
                    if:^BOOL{
        return NO;
    }
                  else:elsex];
}

- (void)fh_timeMatch:(BOOL (^)(id obj))match
                  if:(BOOL(^)(void))ifx
                else:(BOOL(^)(void))elsex {
    [self fh_timesMatch:match
                     if:^BOOL(NSInteger idx, id object) {
        return ifx();
    }
                   else:^BOOL(NSInteger idx, id object) {
        return elsex();
    }];
}

- (void)fh_timesMatch:(BOOL (^)(id obj))match
                   if:(BOOL(^)(NSInteger idx,id object))ifx {
    [self fh_timesMatch:match
                     if:ifx
                   else:^BOOL(NSInteger idx, id object) {
        return NO;
    }];
}

- (void)fh_timesMatch:(BOOL (^)(id obj))match
                 else:(BOOL(^)(NSInteger idx,id object))elsex {
    [self fh_timesMatch:match
                     if:^BOOL(NSInteger idx, id object) {
        return NO;
    }
                   else:elsex];
}

- (void)fh_timesMatch:(BOOL (^)(id obj))match
                   if:(BOOL(^)(NSInteger idx,id object))ifx
                 else:(BOOL(^)(NSInteger idx,id object))elsex {
    NSParameterAssert(match);
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = match(obj)?ifx(idx,obj):elsex(idx,obj);
    }];
}

- (void)fh_timesMatch:(BOOL (^)(id))match
                   if:(BOOL (^)(NSInteger, id))ifx
              endElse:(dispatch_block_t)endBlock {
    NSCParameterAssert(match);
    __block BOOL matched = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        matched = (*stop) = match(obj);
        if (matched) ifx(idx,obj);
    }];
    if (matched == NO) {
        endBlock();
    }
}

- (NSArray *)fh_map:(id (^)(id))block {
    NSMutableArray *new = [self fh_mutableValue];
    [new fh_map:block];
    return [new copy];
}

- (NSArray *)fh_maps:(id (^)(NSInteger, id))block {
    NSMutableArray *new = [self fh_mutableValue];
    [new fh_maps:block];
    return [new copy];
}

- (NSArray *)fh_filterMap:(id(^)(id obj,BOOL *filter))block {
    NSCParameterAssert(block);
    return [self fh_filterMaps:^id(id obj, BOOL *filter, NSInteger idx) {
        return block(obj,filter);
    }];
}

- (NSArray *)fh_filterMaps:(id (^)(id, BOOL *, NSInteger))block {
    NSCParameterAssert(block);
    NSMutableArray *new = [NSMutableArray array];
    BOOL* filter = malloc(sizeof(BOOL));
    [self fh_enum:^(NSInteger idx, id object) {
        *filter = YES;
        id newObj = block(object,filter,idx);
        !*filter?:[new addObject:newObj];
    }];
    free(filter);
    return [new copy];
}

- (NSArray *)fh_reversalify {
    NSMutableArray *new = [self fh_mutableValue];
    [new fh_reversalify];
    return [new copy];
}

- (NSArray<NSNumber *> *)fh_indexesInOther:(NSArray *)other
                                matchBlock:(BOOL(^)(id,id))matchBlock {
    return [self fh_map:^id(id obj) {
        __block NSInteger index = -1;
        [other fh_enum:^(NSInteger idx, id object) {
            if (matchBlock(obj,object)) {index = idx;return;};
        }];
        return @(index);
    }];
}

- (NSString *)fh_stringify {
    return [self fh_stringifyWithSeparator:@","];
}

- (NSString *)fh_stringifyWithSeparator:(NSString *)str {
    NSMutableString *result = [NSMutableString string];
    [self fh_enum:^(NSInteger idx, id object) {
        [result appendFormat:@"%@%@",object,str];
    }];
    [result fh_deleteLast];
    return [result copy];
}

- (NSArray *)fh_offset:(NSInteger)offset {
    if (offset >= self.count) return nil;
    return [self fh_subArrWithRange:NSMakeRange(offset, self.count-offset)];
}

- (NSArray *)fh_subArrWithRange:(NSRange)aRange {
    if (aRange.location >= self.count || aRange.location + aRange.length > self.count) return nil;
    NSMutableArray *result = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= aRange.location && idx < aRange.location + aRange.length)
            [result addObject:obj];
        else if (idx >= aRange.location + aRange.length)
            *stop = YES;
    }];
    return [result copy];
}

- (id)fh_findObject:(BOOL (^)(id))match {
    __block id obj = nil;
    [self fh_timesMatch:^BOOL(id obj) {
        return match(obj);
    } if:^BOOL(NSInteger idx, id object) {
        obj = object;
        return YES;
    }];
    return obj;
}

@end

@implementation NSMutableArray (FHExtend)

- (id)fh_pop {
    id value = self.lastObject;
    [self removeLastObject];
    return value;
}

- (void)fh_prependObject:(id)anObject {
    !anObject?:[self insertObject:anObject atIndex:0];
}

- (void)fh_filter:(BOOL(^)(id))block {
    NSCParameterAssert(block);
    for (int i=0; i<self.count; i++) {
        if (!block(self[i])) {
            [self removeObjectAtIndex:i];
            i--;
        }
    }
}

- (void)fh_map:(id (^)(id))block {
    NSCParameterAssert(block);
    [self fh_enum:^(NSInteger idx, id object) {
        [self replaceObjectAtIndex:idx withObject:block(object)];
    }];
}

- (void)fh_maps:(id (^)(NSInteger, id))block {
    NSCParameterAssert(block);
    [self fh_enum:^(NSInteger idx, id object) {
        [self replaceObjectAtIndex:idx withObject:block(idx,object)];
    }];
}

- (void)fh_filterMap:(id (^)(id, BOOL *))block {
    NSCParameterAssert(block);
    [self fh_filterMaps:^id(id obj, BOOL *filter, NSInteger idx) {
        return block(obj,filter);
    }];
}

- (void)fh_filterMaps:(id (^)(id, BOOL *, NSInteger))block {
    NSCParameterAssert(block);
    BOOL *filter = malloc(sizeof(BOOL));
    for (__block int i=0; i<self.count; i++) {
        *filter = YES;
        id newObj = block(self[i],filter,i);
        *filter?[self replaceObjectAtIndex:i withObject:newObj]:^{[self removeObjectAtIndex:i];i--;}();
    }
    free(filter);
}

- (void)fh_reversalify {
    [self fh_times:self.count/2 block:^(id obj, NSInteger idx) {
        [self exchangeObjectAtIndex:idx withObjectAtIndex:self.count-idx-1];
    }];
}

- (NSArray<NSNumber *> *)fh_indexesInOther:(NSArray *)other matchBlock:(BOOL (^)(id, id))matchBlock {
    NSCParameterAssert(matchBlock);
    NSArray *new = [self copy];
    return [new fh_indexesInOther:other matchBlock:matchBlock];
}

@end
