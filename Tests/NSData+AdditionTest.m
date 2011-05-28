//   
//  NSData+AdditionTest.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  


@interface NSData_Addition : GHTestCase {
}
@end


@implementation NSData_Addition


- (void)testMD5Hash {
    const char *bytes = "frapwings";
    NSData *data = [[NSData alloc] initWithBytes:bytes 
                                          length:strlen(bytes)];
    GHAssertEqualStrings(
        [data md5Hash], @"725d742c9c6150e750e1d97b02e48d68", nil);
}

- (void)testSHA1Hash {
    const char *bytes = "frapwings";
    NSData *data = [[NSData alloc] initWithBytes:bytes 
                                          length:strlen(bytes)];

    GHAssertEqualStrings(
        [data sha1Hash], @"7aa3b6080e2babfd7afdb93e43cbf855f9e51830", nil);
}


@end

