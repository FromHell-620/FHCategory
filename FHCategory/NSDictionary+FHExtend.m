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

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)())ifx {
    [self fh_timeMatch:match if:ifx else:^BOOL{
        return NO;
    }];
}

- (void)fh_timeMatch:(BOOL (^)(id key,id obj))match
                else:(BOOL(^)())elsex {
    [self fh_timeMatch:match if:^BOOL{
        return NO;
    } else:elsex];
}

- (void)fh_timeMatch:(BOOL(^)(id key,id obj))match
                  if:(BOOL(^)())ifx
                else:(BOOL(^)())elsex {
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

@end
