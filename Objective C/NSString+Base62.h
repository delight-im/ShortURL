//
//  NSString+Base62.h
//  OCDataStructsAlgo
//
//  Created by Harshad Kale on 7/12/15.
//  Copyright (c) 2015 kalehv.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base62)

+ (NSString *)base62StringWithDecimalNumber:(long long)number;

+ (long long)decimalNumberWithBase62String:(NSString *)string;

@end


//    Examlples to call

//    NSLog(@"%lld", [NSString decimalNumberWithBase62String:@"21"]);
//    NSLog(@"%lld", [NSString decimalNumberWithBase62String:@"123"]);
//    NSLog(@"%lld", [NSString decimalNumberWithBase62String:@"AbCd"]);
//
//    NSLog(@"%@", [NSString base62StringWithDecimalNumber:1234567890]);
//    NSLog(@"%@", [NSString base62StringWithDecimalNumber:125]);
//    NSLog(@"%@", [NSString base62StringWithDecimalNumber:10]);