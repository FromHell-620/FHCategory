//
//  NSData+FHCategory.h
//  FHCategroyDemo
//
//  Created by 李浩 on 2017/4/26.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FHExtend)

- (NSString*)fh_stringValue;

- (NSData*)fh_md5Data;

- (NSString*)fh_md5String;

- (NSData *)fh_sha1Data;

- (NSString *)fh_sha1String;

- (id)fh_jsonValue;

@end
