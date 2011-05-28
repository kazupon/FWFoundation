//   
//  NSDictionary+AdditionTest.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSDictionary+Addition.h"


@interface NSDictionary_AdditionTest : GHTestCase {
}
@end


@implementation NSDictionary_AdditionTest

- (void)testIsExist {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"hello" 
                                                     forKey:@"world"];
    GHAssertTrue([dict isExist:@"world"], nil);
    GHAssertFalse([dict isExist:@"hello"], nil);
    GHAssertFalse([dict isExist:[[[NSObject alloc] init] autorelease]], nil);
    GHAssertFalse([dict isExist:nil], nil);
}

@end

