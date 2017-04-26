//
//  NSNumber+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "NSNumber+FHExtend.h"

@implementation NSNumber (FHExtend)

+ (NSNumber*)fh_randomNumber:(NSInteger)max {
    return [NSNumber numberWithInteger:(NSInteger)arc4random_uniform((u_int32_t)max)+1];
}

- (void)fh_time:(dispatch_block_t)time {
    [self fh_times:^(NSInteger idx) {
        time();
    }];
}

- (void)fh_times:(void(^)(NSInteger idx))times {
    NSInteger now = 0;
    NSInteger current = self.integerValue;
    while (now < current) {
        times(now);
        now ++;
    };
}

@end
