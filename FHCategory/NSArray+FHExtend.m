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
    NSParameterAssert(block);
    NSMutableArray* new = self.fh_mutableValue;
    [self fh_enum:^(NSInteger idx, id object) {
        if (block(object)) [new removeObjectAtIndex:idx];
    }];
    return new.copy;
}

- (void)fh_times:(NSInteger)times block:(void (^)(id obj))block {
    [@(times) fh_times:^(NSInteger idx) {
        if (idx < self.count) block(self[idx]);
    }];
}

@end
