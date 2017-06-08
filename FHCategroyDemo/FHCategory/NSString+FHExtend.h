//
//  NSString+FHExtend.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FHExtend)

+ (instancetype)fh_stringForUUID;

- (instancetype)fh_stringDeleteSpace;

- (instancetype)fh_stringDeleteString:(NSString*)str;

- (NSData*)fh_md5Data;

- (NSString*)fh_md5String;

- (NSData *)fh_sha1Data;

- (NSString *)fh_sha1String;

- (NSData*)fh_dataValue;

- (NSURL*)fh_urlValue;

- (Class)fh_classify;

- (NSRange)fh_range;

- (id)fh_json;

@end

@interface NSMutableString (FHExtend)

- (void)fh_deleteLast;

@end
