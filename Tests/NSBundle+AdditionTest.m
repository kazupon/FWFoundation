//   
//  NSBundle+AdditionTest.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  


@interface NSBundle_AdditionTest : GHTestCase {
}
@end


@implementation NSBundle_AdditionTest

- (void)testBundleFromMainBundleReleativePath {
    NSString *key = @"Hoge";
    NSString *value = @"Foo";
    NSBundle *bundle = 
        [NSBundle bundleFromMainBundleRelativePath:@"FWFoundation.bundle"];
    GHAssertNotNil(bundle, nil);
    GHAssertEqualStrings(value, [bundle localizedStringForKey:key 
                                                        value:value 
                                                        table:nil], nil);
}

@end

