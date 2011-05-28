//   
//  NSObject+AdditionTest.m
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-28
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSObject+Addition.h"


@interface MyHoge : NSObject {
}
- (NSString *)foo:(NSString *)msg age:(NSInteger)age;
- (BOOL)bar:(int)age name:(NSString *)name;
@end

@implementation MyHoge
- (id)foo:(NSString *)msg age:(NSInteger)age {
    DEBUG(@"foo:%@ age:%d", msg, age);
    return self;
}
- (BOOL)bar:(int)age name:(NSString *)name {
    DEBUG(@"bar:%d name:%@", age, name);
    return YES;
} 
@end


@interface NSObject_AdditionTest : GHTestCase {
}
@end


@implementation NSObject_AdditionTest


- (void)testPerformToTarget {
    NSMutableString *hoge = [NSMutableString stringWithString:@""];
    NSString *hogeStr = @"hoge";
    NSString *spaceStr = @" ";
    
    id newHoge = [NSObject performToTarget:hoge 
                              withSelector:@selector(appendString:)
                             withArguments:hogeStr, nil];
    GHAssertEqualStrings(@"hoge", hoge, nil);

    newHoge = [NSObject performToTarget:hoge
                           withSelector:@selector(description)
                          withArguments:nil];
    GHAssertEqualStrings(@"hoge", hoge, nil); 
}

- (void)testPerformSelector {
    id hoge = [[[MyHoge alloc] init] autorelease];
    id result = [hoge performSelector:@selector(foo:age:) 
                           withObjets:@"hello", [NSNumber numberWithInteger:24], nil];
    GHAssertEqualObjects(hoge, result, nil);

    result = [hoge performSelector:@selector(bar:name:) 
                        withObjets:[NSNumber numberWithInt:14], @"kazupon", nil];
    GHAssertTrue(result, nil);
}


@end

