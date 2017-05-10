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

- (NSData*)fh_jsonDataValue {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    return nil;
}

- (NSString*)fh_jsonStringValue {
    return [[self fh_jsonDataValue] fh_stringValue];
}

- (NSMutableArray*)fh_mutableValue {
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

- (NSArray*)fh_filter:(BOOL(^)(id obj))block {
    NSMutableArray* new = self.fh_mutableValue;
    [new fh_filter:block];
    return [new copy];
}

- (void)fh_times:(NSInteger)times
           block:(void (^)(id obj))block {
    [@(times) fh_times:^(NSInteger idx) {
        if (idx < self.count) block(self[idx]);
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

- (NSArray*)fh_map:(id (^)(id))block {
    NSMutableArray* new = [self mutableCopy];
    [new fh_map:block];
    return [new copy];
}

- (NSArray*)fh_filterMap:(id(^)(id obj,BOOL* filter))block {
    NSCParameterAssert(block);
    NSMutableArray* new = [NSMutableArray array];
    BOOL* filter = malloc(sizeof(BOOL));
    [self fh_enum:^(NSInteger idx, id object) {
        *filter = YES;
        id newObj = block(object,filter);
        !*filter?:[new addObject:newObj];
    }];
    free(filter);
    return [new copy];
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

- (void)fh_filterMap:(id (^)(id, BOOL *))block {
    NSCParameterAssert(block);
    BOOL* filter = malloc(sizeof(BOOL));
    for (int i =0; i<self.count; i++) {
        *filter = YES;
        id newObj = block(self[i],filter);
        *filter?[self replaceObjectAtIndex:i withObject:newObj]:[self removeObjectAtIndex:i];
        i--;
    }
    free(filter);
}

@end
