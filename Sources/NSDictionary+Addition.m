//   
//  NSDictionary+Addition.m
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

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
