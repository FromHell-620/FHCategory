//
//  NSNumber+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (FHExtend)

+ (NSNumber*)fh_randomNumber:(NSInteger)max;

- (void)fh_times:(void (^)(NSInteger idx))times;

@end
