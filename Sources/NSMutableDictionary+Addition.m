//   
//  NSMutableDictionary+Addition.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2010-12-09.
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSMutableDictionary+Addition.h"

@implementation NSMutableDictionary (Addition)

- (BOOL)isExist:(id)key {
    DEBUG(@"isExist:%@", key);

    if (!key) {
        return NO;
    }

    id value = [self objectForKey:key];
    if (value) {
        return YES;
    } else {
        return NO;
    } 
}

@end
