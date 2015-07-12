//
//  NSString+Base62.m
//  OCDataStructsAlgo
//
//  Created by Harshad Kale on 7/12/15.
//  Copyright (c) 2015 kalehv.me. All rights reserved.
//

#import "NSString+Base62.h"
// Total available alphabets for Base 62
// 0 to 9 = 10
// A to Z = 26
// a to z = 26
//-------------
// Total  = 62 (That is why Base'62')
NSInteger const kBase = 62;
// index of 0 in Alphabets
NSInteger const kNumbersOffset = '0';
// index of 'A' in Alphabets = offset for 0 to 9
NSInteger const kUppercaseOffset = 'A' - 10;
// index of 'a' in Alphabets = offset for uppercase 26 characters and 0 to 9
NSInteger const kLowercaseOffset = 'a' - 26 - 10;

@implementation NSString (Base62)

#pragma mark - Private Methods

+ (NSInteger)integerWithChar:(char)c {
    NSInteger digit = 0;
    
    if ('0' <= c && c <= '9') {
        digit = c - kNumbersOffset;
    }
    else if ('A' <= c && c <= 'Z') {
        digit = c - kUppercaseOffset;
    }
    else if ('a' <= c && c <= 'z') {
        digit = c - kLowercaseOffset;
    }
    
    return digit;
}

+ (char)charWithInteger:(NSInteger)integer {
    char c = ' ';
    
    if (0 <= integer && integer <= 9) {
        c = (char)integer;
    }
    else if (10 <= integer && integer <= 35) {
        c = (char)(kUppercaseOffset + integer);
    }
    else if (36 <= integer && integer < kBase) {
        c = (char)(kLowercaseOffset + integer);
    }
    
    return c;
}

#pragma mark - Public Methods

+ (NSString *)base62StringWithDecimalNumber:(long long)decimalNumber {
    NSMutableArray *multipliers = [NSMutableArray array];
    
    while (decimalNumber > 0) {
        NSInteger remainder = decimalNumber % kBase;
        [multipliers addObject:@(remainder)];
        decimalNumber /= kBase;
    }
    
    NSMutableString *base62String = [NSMutableString string];
    NSEnumerator *enumerator = [multipliers reverseObjectEnumerator];
    for (NSNumber *n in enumerator) {
        [base62String appendFormat:@"%c", [[self class] charWithInteger:[n integerValue]]];
    }
    
    return base62String;
}

+ (long long)decimalNumberWithBase62String:(NSString *)base62String {
    long long decimalNumber = 0;
    NSInteger lengthOffset = base62String.length - 1;
    
    for (NSInteger i = lengthOffset; i >= 0; i--) {
        char c = [base62String characterAtIndex:i];
        decimalNumber += [[self class] integerWithChar:c] * (pow(kBase, lengthOffset - i));
    }
    
    return decimalNumber;
}

@end
