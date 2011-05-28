//   
//  FWHttpClient.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "FWHttpClient.h"
#import <GTMiOS/GTMiOS.h>


@interface FWHttpClient (Private)

- (NSMutableURLRequest *)makeRequest:(NSString *)url 
                             timeout:(NSTimeInterval)interval;
- (NSMutableURLRequest *)makeRequest:(NSString *)url 
                             timeout:(NSTimeInterval)interval 
                            username:(NSString *)username 
                            password:(NSString*)password;
- (BOOL)checkRangeOfHttpStatusCode:(int)status;
- (FWHttpClientContentType)getContentTypeFrom:(NSString *)contentTypeString;
- (NSDictionary *)makeHttpInfo:(NSHTTPURLResponse *)response;

@end


@implementation FWHttpClient


@synthesize timeout = _timeout;


#pragma mark -
#pragma mark memory

- (id)initWithDelegate:(id)delegate {
    DEBUG(@"initWithDelegate:%@", delegate);
    
    if (self = [super init]) {
        _recievedData = [[NSMutableData alloc] init];
        _contentType = FWHttpClientContentTypeUnknown;
        _statusCode = 0;
        _delegate = delegate;
        _timeout = 20.0;
        _responses = nil;
    }
    
    NSAssert((self != nil), nil);
    return self;
}


- (void)dealloc {
    DEBUG(@"dealloc");
    NSAssert(_recievedData != nil, nil);
    
    _delegate = nil;
    
    [_recievedData release];
    INFO(@"release _recievedData");
    
    if (_responses) {
        [_responses release];
        INFO(@"release _responses");
    }
    
    if (_connection) {
        [_connection release];
        INFO(@"release _connection");
    }
    
    [super dealloc];
}


- (void)requestGET:(NSString *)url {
    DEBUG(@"requestGET:%@", url);
    NSAssert(url != nil, nil);
    
    [self reset];
    
    NSMutableURLRequest *request = [self makeRequest:url timeout:_timeout];
    NSAssert(request != nil, nil);
    [request setHTTPMethod:@"GET"];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
    
    NSAssert(_connection != nil, nil);
}


- (void)requestPOST:(NSString *)url body:(NSString *)body {
    DEBUG(@"requestPOST:%@, body:%@", url, body);    
    NSAssert(url != nil, nil);
    NSAssert(body != nil, nil);

    
    NSMutableURLRequest *request = [self makeRequest:url timeout:_timeout];
    NSAssert(request != nil, nil);
    [request setHTTPMethod:@"POST"];
    //[request setHTTPBody: [[body stringByEscapingForHTML] 
    [request setHTTPBody: [[body gtm_stringByEscapingForHTML]
                                 dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
    
    NSAssert(_connection != nil ,nil);
}


- (void)requestGET:(NSString *)url 
          username:(NSString *)username 
          password:(NSString *)password {
    DEBUG(@"requestGET:%@", url);
    NSAssert(url != nil, nil);
    
    [self reset];
    
    NSMutableURLRequest *request = [self makeRequest:url 
                                             timeout:_timeout 
                                            username:username 
                                            password:password];
    NSAssert(request != nil, nil);
    [request setHTTPMethod:@"GET"];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
    
    NSAssert(_connection != nil, nil);
}


- (void)requestPOST:(NSString *)url body:(NSString *)body 
        username:(NSString *)username password:(NSString *)password {
    DEBUG(@"requestPOST:%@ body:%@", url, body);    
    NSAssert(url != nil, nil);
    NSAssert(body != nil, nil);
    
    [self reset];
    
    NSMutableURLRequest *request = [self makeRequest:url 
                                             timeout:_timeout 
                                            username:username 
                                            password:password];
    NSAssert(request != nil, nil);
    
    //NSString *escapedBody = [body stringByEscapingForHTML];
    NSString *escapedBody = [body gtm_stringByEscapingForHTML];
    INFO(@"escapedBody : %@", escapedBody);
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:
        [escapedBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
    
    NSAssert(_connection != nil ,nil);
}


- (void)requestDELETE:(NSString *)url {
    DEBUG(@"requestDELETE:%@", url);
    
    // TODO: should implment !!
    [NSException raise:FWNotImplementedException 
                format:@"Not Implementd %@" arguments:@"cancel"];
}


- (void)requestDELETE:(NSString *)url 
             username:(NSString *)username 
             password:(NSString *)password {
    DEBUG(@"requestDELETE:%@", url);
    NSAssert(url != nil, nil);
    NSAssert(username != nil, nil);
    NSAssert(password != nil, nil);
    
    [self reset];
    
    NSMutableURLRequest *request = [self makeRequest:url 
                                             timeout:_timeout 
                                            username:username 
                                            password:password];
    NSAssert(request != nil, nil);
    [request setHTTPMethod:@"DELETE"];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
    
    
    NSAssert(_connection != nil ,nil);
}


- (void)cancel {
    DEBUG(@"cancel");

    // TODO: should implment !!
    [NSException raise:FWNotImplementedException 
                format:@"Not Implementd %@" arguments:@"cancel"];
}


- (void)reset {
    DEBUG(@"reset");
    
    NSAssert(_recievedData != nil, nil);
    
    _contentType = FWHttpClientContentTypeUnknown;
    _statusCode = 0;
    
    [_recievedData release];
    INFO(@"release _recievedData");
    _recievedData = [[NSMutableData alloc] init];
    
    if (_responses) {
        [_responses release];
        INFO(@"release _response");
    }

    if (_connection) {
        [_connection release];
        INFO(@"release _connection");
    }
}


#pragma mark -
#pragma mark private

- (NSMutableURLRequest *)makeRequest:(NSString *)url
                             timeout:(NSTimeInterval)interval {
    DEBUG(@"makeRequest:%@ timeout:%d", url, interval);
    NSAssert(url != nil, nil);

    
    NSString *encodedUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                               NULL, (CFStringRef)url, NULL, NULL, 
                                                                               kCFStringEncodingUTF8
                                                                               );
    NSAssert(encodedUrl != nil, nil);
    
    NSMutableURLRequest *request = 
    [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:encodedUrl]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:interval];
    [request setHTTPShouldHandleCookies:NO];
    [encodedUrl release];
    
    NSAssert(request != nil, nil);
    return request;
}


- (NSMutableURLRequest *)makeRequest:(NSString *)url 
                             timeout:(NSTimeInterval)interval
                            username:(NSString *)username 
                            password:(NSString *)password {
    DEBUG(@"makeRequest:%@ timeout:%d", url, interval);
    NSAssert(url != nil, nil);
    NSAssert(username != nil, nil);
    NSAssert(password != nil, nil);
    
    NSMutableURLRequest *request = [self makeRequest:url timeout:interval];
    NSAssert(request != nil, nil);
    
    NSString *authorizeParameter = 
    [NSString stringWithFormat:@"%@:%@", username, password];
    GTMStringEncoding *coder = 
        [GTMStringEncoding rfc4648Base64WebsafeStringEncoding];
    //BBStringEncoding *coder = 
    //    [BBStringEncoding rfc4648Base64WebsafeStringEncoding];
    NSString *authorizeHeader = [@"Basic " stringByAppendingString:
                                     [coder encodeString:authorizeParameter]];
    INFO(@"authorizeHeader : %@", authorizeHeader);
    [request setValue:authorizeHeader forHTTPHeaderField:@"Authorization"];
    
    NSAssert(request != nil, nil);
    return request;
}


- (BOOL)checkRangeOfHttpStatusCode:(int)status {
    DEBUG(@"checkRangeOfHttpStatusCode:%d", status);
    
    BOOL result = NO;
    switch(status) {
        case 100:
        case 101:
        case 200:
        case 201:
        case 202:
        case 203:
        case 204:
        case 205:
        case 206:
        case 300:
        case 301:
        case 302:
        case 303:
        case 304:
        case 305:
        case 306:
        case 400:
        case 401:
        case 402:
        case 403:
        case 404:
        case 405:
        case 406:
        case 407:
        case 408:
        case 409:
        case 410:
        case 411:
        case 412:
        case 413:
        case 414:
        case 415:
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 505:
            result = YES;
            break;
        default:
            result = NO;
            break;
    }
    
    return result;
}


- (FWHttpClientContentType)getContentTypeFrom:(NSString *)contentTypeString {
    DEBUG(@"getContentTypeFrom:%@", contentTypeString);
    NSAssert(contentTypeString != nil, nil);

    FWHttpClientContentType type = FWHttpClientContentTypeUnknown;
    if ([contentTypeString rangeOfString:@"xml"].location != NSNotFound) {
        type = FWHttpClientContentTypeXml;
    } else if ([contentTypeString rangeOfString:@"html"].location != NSNotFound) {
        type = FWHttpClientContentTypeHtml;
    } else if ([contentTypeString rangeOfString:@"text"].location != NSNotFound) {
        type = FWHttpClientContentTypeText;
    } else if ([contentTypeString rangeOfString:@"image"].location != NSNotFound) {
        type = FWHttpClientContentTypeImage;
    }
    
    return type;
}


- (NSDictionary *)makeHttpInfo:(NSHTTPURLResponse *)response {
    DEBUG(@"makeHttpInfo:%@", response);
    NSAssert(response != nil, nil);

    NSMutableDictionary *httpInfo = [NSMutableDictionary dictionary];
    [httpInfo setValue:[[response URL] absoluteString] forKey:@"absoluteString"];
    [httpInfo setValue:[[response URL] fragment] forKey:@"fragment"];
    [httpInfo setValue:[[response URL] host] forKey:@"host"];
    [httpInfo setValue:[[response URL] parameterString] forKey:@"parameterString"];
    [httpInfo setValue:[[response URL] password] forKey:@"password"];
    [httpInfo setValue:[[response URL] path] forKey:@"path"];
    [httpInfo setValue:[[response URL] port] forKey:@"port"];
    [httpInfo setValue:[[response URL] query] forKey:@"query"];
    [httpInfo setValue:[[response URL] relativePath] forKey:@"relativePath"];
    [httpInfo setValue:[[response URL] relativeString] forKey:@"relativeString"];
    [httpInfo setValue:[[response URL] resourceSpecifier] forKey:@"resourceSpecifier"];
    [httpInfo setValue:[[response URL] scheme] forKey:@"scheme"];
    [httpInfo setValue:[[response URL] user] forKey:@"user"];
    [httpInfo setValue:[response MIMEType] forKey:@"MIMEType"];
    [httpInfo setValue:[response textEncodingName] forKey:@"textEncodingName"];

    [httpInfo setDictionary:[response allHeaderFields]];
    
    NSAssert(httpInfo != nil, nil);
    return httpInfo;
}


#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    DEBUG(@"connection:%@ didReceiveData:%p", connection, data);
    NSAssert(_recievedData != nil, nil);
    
    [_recievedData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DEBUG(@"connectionDidFinishLoading:%@", connection);
    DEBUG(@"_contentType = %d, _statusCode = %d", _contentType, _statusCode);
    NSAssert(_recievedData != nil, nil);
    NSAssert(_contentType != FWHttpClientContentTypeUnknown, nil);
    
    if ([self checkRangeOfHttpStatusCode:_statusCode]) {
        // execute delegate
        if (_delegate) {
            [_delegate httpClient:self 
                didSucceedRequest:[NSData dataWithData:_recievedData] 
                      contentType:_contentType 
                       statusCode:_statusCode
                         httpInfo:[NSDictionary dictionaryWithDictionary:_responses]];
        }
    } else {
        ERROR(@"Occured Invalid HTTP StatusCode !!!");
        // TODO should implement error !!
        //[delegate httpClient:self didFailWithError:nil];
    }
}


- (void)connection:(NSURLConnection *)connection 
  didFailWithError:(NSError *)error {
    DEBUG(@"connection:%@ didFailWithError:%@", connection, error);
    
    // execute delegate
    if (_delegate) {
        // TODO sould impement error mapping !!
        [_delegate httpClient:self didFailedRequest:error];
    }
}


/*
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection 
                         willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}
*/


- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    DEBUG(@"connection:%@ didReceiveResponse:%@", connection, response);
    
    // get status code
    _statusCode = [(NSHTTPURLResponse *)response statusCode];
    
    // get http info
    _responses = [self makeHttpInfo:(NSHTTPURLResponse *)response];
    [_responses retain];

    // get content type
    NSString *contentTypeString = [_responses objectForKey:@"Content-Type"];
    if (contentTypeString) {
        _contentType = [self getContentTypeFrom:contentTypeString];
    } 

    DEBUG(@"_contentType = %d, _statusCode = %d", _contentType, _statusCode);
}


/*
- (NSURLRequest *)connection:(NSURLConnection *)connection 
                  willSendRequest:(NSURLRequest *)request 
                  redirectResponse:(NSURLResponse *)redirectResponse
{
    return nil;
}
*/


/*
- (void)connection:(NSURLConnection *)connection 
        didSendBodyData:(NSInteger)bytesWritten 
        totalBytesWritten:(NSInteger)totalBytesWritten 
        totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
*/


/*
- (BOOL)connection:(NSURLConnection *)connection 
        canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}
*/


/*
- (void)connection:(NSURLConnection *)connection 
        didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}
*/


/*
- (void)connection:(NSURLConnection *)connection 
        didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}
*/


/*
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}
*/


@end

