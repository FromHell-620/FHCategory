//
//  NSDictionary+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/30.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "NSDictionary+FHExtend.h"
#import "NSArray+FHExtend.h"

@implementation NSDictionary (FHExtend)

- (id)fh_randomKey {
    return [[self allKeys] fh_randomObject];
}

- (id)fh_randomValue {
    return self[[[self allKeys] fh_randomObject]];
}

- (void)fh_enmu:(void (^)(id, id))block {
    NSCParameterAssert(block);
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key,obj);
    }];
}

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)(void))ifx {
    [self fh_timeMatch:match if:ifx else:^BOOL{
        return NO;
    }];
}

- (void)fh_timeMatch:(BOOL (^)(id key,id obj))match
                else:(BOOL(^)(void))elsex {
    [self fh_timeMatch:match if:^BOOL{
        return NO;
    } else:elsex];
}

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)(void))ifx
                else:(BOOL(^)(void))elsex {
    [self fh_timesMatch:match if:^BOOL(id key, id obj) {
        return ifx();
    } else:^BOOL(id key, id obj) {
        return elsex();
    }];
}

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                   if:(BOOL(^)(id key,id obj))ifx {
    [self fh_timesMatch:match if:ifx else:^BOOL(id key, id obj) {
        return NO;
    }];
}

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                 else:(BOOL(^)(id key,id obj))elsex {
    [self fh_timesMatch:match if:^BOOL(id key, id obj) {
        return NO;
    } else:elsex];
}

- (void)fh_timesMatch:(BOOL(^)(id key,id obj))match
                   if:(BOOL(^)(id key,id obj))ifx
                 else:(BOOL(^)(id key ,id obj))elsex {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        *stop = match(key,obj)?ifx(key,obj):elsex(key,obj);
    }];
}

- (NSDictionary*)fh_filter:(BOOL (^)(id, id))block {
    NSCParameterAssert(block);
    NSMutableDictionary* new = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self fh_timesMatch:^BOOL(id key, id obj) {
        return block(key,obj);
    } if:^BOOL(id key, id obj) {
        [new setObject:obj forKey:key];
        return NO;
    }];
    return [new copy];
}

- (NSDictionary*)fh_map:(id (^)(id, id))block {
    NSCParameterAssert(block);
    NSMutableDictionary* new = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self fh_enmu:^(id key, id value) {
        [new setObject:block(key,value) forKey:key];
    }];
    return [new copy];
}

- (NSDictionary*)fh_filterMap:(id (^)(id, id, BOOL *))block {
    NSCParameterAssert(block);
    NSMutableDictionary* new = [NSMutableDictionary dictionaryWithCapacity:self.count];
    BOOL* filter = malloc(sizeof(BOOL));
    __block id new_obj = nil;
    [self fh_timesMatch:^BOOL(id key, id obj) {
        *filter = YES;
        new_obj = block(key,obj,filter);
        return *filter;
    } if:^BOOL(id key, id obj) {
        [new setObject:new_obj forKey:key];
        return NO;
    }];
    free(filter);
    return [new copy];
}

@end

@implementation NSMutableDictionary (FHExtend)

- (void)fh_filter:(BOOL (^)(id, id))block {
    [self fh_timesMatch:block else:^BOOL(id key, id obj) {
        [self removeObjectForKey:key];
        return NO;
    }];
}

- (void)fh_map:(id(^)(id,id))block {
    [self fh_enmu:^(id key, id value) {
        [self setObject:block(key,value) forKey:key];
    }];
}

- (void)fh_filterMap:(id (^)(id, id, BOOL *))block {
    BOOL* filter = malloc(sizeof(BOOL));
    __block id new_obj = nil;
    [self fh_timesMatch:^BOOL(id key, id obj) {
        *filter = YES;
        new_obj = block(key,obj,filter);
        return *filter;
    } if:^BOOL(id key, id obj) {
        [self setObject:new_obj forKey:key];
        return NO;
    } else:^BOOL(id key, id obj) {
        [self removeObjectForKey:key];
        return NO;
    }];
    free(filter);
}
@end
