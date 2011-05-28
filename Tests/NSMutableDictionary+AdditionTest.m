//   
//  NSMutableDictionary+AdditionTest.m
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSMutableDictionary+Addition.h"


@interface NSMutableDictionary_AdditionTest : GHTestCase {
}
@end


@implementation NSMutableDictionary_AdditionTest

- (void)testIsExist {
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithObject:@"hello" forKey:@"world"];
    GHAssertTrue([dict isExist:@"world"], nil);
    GHAssertFalse([dict isExist:@"hello"], nil);
    GHAssertFalse([dict isExist:[[[NSObject alloc] init] autorelease]], nil);
    GHAssertFalse([dict isExist:nil], nil);
}

@end

