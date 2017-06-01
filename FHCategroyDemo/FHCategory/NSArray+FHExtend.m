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

@implementation NSArray (FHExtend)

- (id)fh_randomObject {
    return [self objectAtIndex:[NSNumber fh_randomNumber:self.count-1].integerValue];
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
                  if:(BOOL(^)())ifx {
    [self fh_timeMatch:match
                    if:ifx
                  else:^BOOL{
        return NO;
    }];
}

- (void)fh_timeMatch:(BOOL (^)(id obj))match
                else:(BOOL(^)())elsex {
    [self fh_timeMatch:match
                    if:^BOOL{
        return NO;
    }
                  else:elsex];
}

- (void)fh_timeMatch:(BOOL (^)(id obj))match
                  if:(BOOL(^)())ifx
                else:(BOOL(^)())elsex {
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
        [self fh_enum:^(NSInteger idx, id object) {
            if (matchBlock(obj,object)) {index = idx;return;};
        }];
        return @(index);
    }];
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
