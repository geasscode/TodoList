//
//  NSString+MessageDigest.h
//  ToDoListApp
//
//  Created by desmond on 11/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MessageDigest)

- (NSString *)md2;

- (NSString *)md4;

- (NSString *)md5;

- (NSString *)sha1;

- (NSString *)sha224;

- (NSString *)sha256;

- (NSString *)sha384;

- (NSString *)sha512;

NSString *GenID(NSString* prefix);


@end