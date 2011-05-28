//   
//  FWHttpClientTest.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "FWHttpClient.h"


@interface FWHttpClientTest : GHTestCase {
    BOOL receivedRequestResult;
}
@end


@implementation FWHttpClientTest

// used timings
const NSTimeInterval kGiveUpInterval = 3.0;
const NSTimeInterval kRunLoopInterval = 0.01;


#pragma mark -
#pragma mark setUp & teardown

- (void)setUp {
    receivedRequestResult = NO;
}


- (void)tearDown {

}


#pragma mark -
#pragma mark test

- (void)testInitWithDelegate {
    
    FWHttpClient *client = 
                    [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    GHAssertTrue(client.timeout == 20.0, nil);

}


- (void)testRequestGetWithURL {

    FWHttpClient *client = 
                    [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    NSString *url = nil;
     
    // HTTP Status.
    for(NSNumber *status in [self createStatuses]) {
        url = [NSString stringWithFormat:@"http://localhost:8080/test?type=text-plain&status=%d", [status intValue], nil];
        GHAssertNoThrow([client requestGET:url], nil);
        [self waitForRequestResult];
        receivedRequestResult = NO;
    }
    
    // Content-Type.
    for(NSString *type in [self createContentTypes]) {
        url = [NSString stringWithFormat:@"http://localhost:8080/test?type=%@&status=200", type, nil];
        GHAssertNoThrow([client requestGET:url], nil);
        [self waitForRequestResult];
        receivedRequestResult = NO;
    }

}


- (void)testRequestGetWithURLAndUserNameAndPassword {
    
    FWHttpClient *client = 
            [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    
    NSString *username = @"hoge";
    NSString *password = @"foo";
    NSString *url = @"http://localhost:8080/test?type=text-html&status=200";
    
    GHAssertNoThrow(
        [client requestGET:url username:username password:password], nil);
    [self waitForRequestResult];
}


- (void)testPostWithURLAndBody {
    
    FWHttpClient *client = 
            [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    
    NSString *url = @"http://localhost:8080/post.xml";
    NSString *body = [NSString stringWithFormat:@"status=%@",
        [@"test" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    ];
    
    GHAssertNoThrow([client requestPOST:url body:body], nil);
    [self waitForRequestResult];
}


- (void)testPostWithURLAndBodyAndUserNameAndPassword {
    
    FWHttpClient *client = 
            [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    
    NSString *username = @"hoge";
    NSString *password = @"foo";
    NSString *url = @"http://localhost:8080/post.xml";
    
    unichar chars[] = {
        34, 38, 39, 60, 62, 338, 339, 352, 353, 376, 710, 732,
        8194, 8195, 8201, 8204, 8205, 8206, 8207, 8211, 8212, 8216, 8217, 8218, 
        8220, 8221, 8222, 8224, 8225, 8240, 8249, 8250, 8364, 
    };
    NSString *string1 = [NSString stringWithCharacters:chars
                                  length:sizeof(chars) / sizeof(unichar)];
    NSArray *bodies = [NSArray arrayWithObjects:
                        @"test", string1, @"<this & that>", @"パン・&ド・カンパーニュ",@"abcا1ب<تdef&", nil];
    //@"test", nil];
    
    for(NSString *element in bodies) {
        DEBUG(@"POGH : %@", element);
        NSString *body = [NSString stringWithFormat:@"status=%@", element, nil];
        GHAssertNoThrow(
            [client requestPOST:url body:body username:username password:password], 
            nil
        );
        [self waitForRequestResult];
        receivedRequestResult = NO;
    }
}


- (void)testDeleteWithURL {
    
    GHFail(nil);
}


- (void)testDeleteWithURLAndUserNameAndPassword {
    
    FWHttpClient *client = 
            [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNotNil(client, nil);
    
    NSString *username = @"hoge";
    NSString *password = @"foo";
    NSString *url = 
        [NSString stringWithFormat:@"http://localhost:8080/delete.xml", nil];
    GHAssertNoThrow(
        [client requestDELETE:url username:username password:password], nil
    );
    
    [self waitForRequestResult];
    receivedRequestResult = NO;
}


- (void)testCancel {
    FWHttpClient *client = 
                    [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNoThrow([client cancel], nil);
}


- (void)testReset {
    FWHttpClient *client = 
                    [[[FWHttpClient alloc] initWithDelegate:self] autorelease];
    GHAssertNoThrow([client reset], nil);
}


#pragma makr -
#pragma mark FWHttpClientDelegate


- (void)httpClient:(FWHttpClient *)client 
 didSucceedRequest:(NSData *)receivedData 
       contentType:(FWHttpClientContentType)contentType 
        statusCode:(NSInteger)status 
          httpInfo:(NSDictionary *)info {
    
    GHAssertNotNil(client != nil, nil);
    GHAssertNotNil(info != nil, nil);
    GHAssertNotNil(receivedData != nil, nil);
    GHAssertTrue(contentType != FWHttpClientContentTypeUnknown, nil);
    GHAssertTrue(100 <= status && status < 600, nil);
    
    DEBUG(@"contentType = %d, status = %d", contentType, status);
    for(id key in info) {
        DEBUG(@"key : %@, value : %@", key, [info objectForKey:key]);
    }
    if(contentType != FWHttpClientContentTypeImage) {
        NSString *receivedDataString = 
                    [[NSString alloc] initWithData:receivedData 
                                          encoding:NSUTF8StringEncoding];
        DEBUG(@"receivedData = %@", receivedDataString);
        [receivedDataString release];
    } else {
        DEBUG(@"receivedData = %@", receivedData);
    }
}
- (void)httpClient:(FWHttpClient *)client 
  didFailedRequest:(NSError *)error {
    
    GHAssertNotNil(client != nil, nil);
    GHAssertNotNil(error != nil, nil);
    
    DEBUG(@"error = %@", error);
    receivedRequestResult = YES;
}


#pragma -
#pragma mark helper


- (void)waitForRequestResult {
    
    NSDate *giveUpDate = [NSDate dateWithTimeIntervalSinceNow:kGiveUpInterval];
    while(!receivedRequestResult && [giveUpDate timeIntervalSinceNow] > 0) {
        NSDate *loopIntervalDate = 
                        [NSDate dateWithTimeIntervalSinceNow:kRunLoopInterval];
        [[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate];
    }

}


- (NSArray *)createStatuses {

    NSMutableArray *array = [NSMutableArray array];

    // create 10x status.
    for(int i = 0; i < 2; i++) {
        [array addObject:[NSNumber numberWithInt:(100 + i)]];
    }

    // create 20x status.
    for(int i = 0; i < 7; i++) {
        [array addObject:[NSNumber numberWithInt:(200 + i)]];
    }

    // create 30x status.
    for(int i = 0; i < 7; i++) {
        [array addObject:[NSNumber numberWithInt:(300 + i)]];
    }

    // create 40x status.
    for(int i = 0; i < 16; i++) {
        [array addObject:[NSNumber numberWithInt:(400 + i)]];
    }

    // create 50x status.
    for(int i = 0; i < 6; i++) {
        [array addObject:[NSNumber numberWithInt:(500 + i)]];
    }

    return array;
}


- (NSArray *)createContentTypes {
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@"text-plain"];
    [array addObject:@"text-html"];
    [array addObject:@"text-xml"];
    [array addObject:@"image-png"];

    return array;
}


@end

