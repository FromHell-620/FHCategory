//
//  NSString+FHExtend.m
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "NSString+FHExtend.h"

@implementation NSString (FHExtend)

+ (instancetype)fh_stringForUUID {
    CFUUIDRef ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef stringRef = CFUUIDCreateString(kCFAllocatorDefault, ref);
    CFRelease(ref);
    return (__bridge NSString *)(stringRef);
}

- (instancetype)fh_stringDeleteSpace {
    return [self fh_stringDeleteString:@" "];
}

- (instancetype)fh_stringDeleteString:(NSString*)str {
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSData*)fh_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSURL*)fh_urlValue {
    return [NSURL URLWithString:self];
}

- (NSRange)fh_range {
    return NSMakeRange(0, self.length);
}

- (id)fh_json {
    return [NSJSONSerialization JSONObjectWithData:[self fh_dataValue] options:kNilOptions error:nil];
}

@end
