//   
//  FWDebugTest.m
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-28
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "FWDebug.h"


@interface FWDebugTest : GHTestCase {
}
@end


@implementation FWDebugTest

#pragma mark -
#pragma mark setup & teardown

- (void)setUp {
    NSLog(@"setup");
}


- (void)tearDown {
    NSLog(@"teardown");
}


#pragma mark -
#pragma mark test

- (void)testPrint {
    FW_DEBUG(@"");
    FW_DEBUG(@"%@ %d %f", @"hello", 1, 1.0);
    FW_INFO(@"");
    FW_INFO(@"%@ %d %f", @"hello", 1, 1.0);
    FW_WARN(@"");
    FW_WARN(@"%@ %d %f", @"hello", 1, 1.0);
    FW_ERROR(@"");
    FW_ERROR(@"%@ %d %f", @"hello", 1, 1.0);
} 

@end

