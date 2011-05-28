//   
//  FWHttpClient.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "FWFoundationDefines.h"


@protocol FWHttpClientDelegate;


/*!
 * @class FWHttpClient
 * @abstract
 *  This class is the HTTP Client.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundatoin 0.1
 */
@interface FWHttpClient : NSObject {
 @protected
    id _delegate;
    NSURLConnection *_connection;
    NSMutableData *_recievedData;
    FWHttpClientContentType _contentType;
    int _statusCode;
    NSDictionary *_responses;
    NSTimeInterval _timeout;
}

/*!
 * @property timerout
 * @abstract
 *  This property is the HTTP access timeout value.
 * @discussion
 *  The value of this property is a NSTimeInterval value.
 *  The default value of this property is '30'.?
 * @availability
 *  FWFoundatoin 0.1
 */
@property (nonatomic) NSTimeInterval timeout;

/*!
 * @method initWithDelegate:
 * @abstract
 *  This method initialize a FWHttpClient object with delegate object.
 * @discussion
 *  TODO: write description ...
 * 
 * @param delegate The delegate object.
 * @result A FWHttpClient object.
 */
- (id)initWithDelegate:(id)delegate;

/*!
 * @method requestGET:
 * @abstract
 *  This method reqeust by HTTP GET method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestGET:(NSString *)url;

/*!
 * @method requestGET:username:password:
 * @abstract
 *  This method request by HTTP GET method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @param username The username.
 * @param password The password.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestGET:(NSString *)url 
          username:(NSString *)username 
          password:(NSString *)password;

/*!
 * @method requestPOST:body:
 * @abstract
 *  This method request by HTTP POST method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @param body A body string.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestPOST:(NSString *)url body:(NSString *)body;

/*!
 * @method requestPOST:body:username:password:
 * @abstract
 *  This method request by HTTP POST method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @param body A body string.
 * @param username The username.
 * @param password The password.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestPOST:(NSString *)url 
               body:(NSString *)body 
           username:(NSString *)username 
           password:(NSString *)password;

/*!
 * @method requestDELETE:
 * @abstract
 *  This method request by HTTP DELETE method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestDELETE:(NSString *)url;

/*!
 * @method requestDELETE:username:password:
 * @abstract
 *  This method request by HTTP DELETE method.
 * @discussion
 *  TODO: write description ...
 *
 * @param url A request URL.
 * @param username The username.
 * @param password The password.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)requestDELETE:(NSString *)url 
             username:(NSString *)username 
             password:(NSString *)password;

/*!
 * @method cancel
 * @abstract
 *  This method cancel a request.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)cancel;

/*!
 * @method reset
 * @abstract
 *  This method reset a FWHttpClient object status.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)reset;


@end


/*!
 * @protocol FWHttpClientDelegate
 * @abstract
 *  This protocol is a delegate of FWHttpClient object.
 * @discussion
 *  TODO: write description ...
 *  
 * @availability
 *  FWFoundatoin 0.1
 */
@protocol FWHttpClientDelegate <NSObject>

@optional

/*!
 * @method httpClient:didSucceedRequest:contentType:statusCode:httpInfo:
 * @abstract
 *  TODO: write description ...
 * @discussion
 *  TODO: write description ...
 *
 * @param client A FWHttpClient object.
 * @param recievedData A recievedData.
 * @param contentType A content type.
 * @param status A HTTP status code.
 * @param info A HTTP Header info.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)httpClient:(FWHttpClient *)client 
 didSucceedRequest:(NSData *)receivedData 
       contentType:(FWHttpClientContentType)contentType 
        statusCode:(NSInteger)status
          httpInfo:(NSDictionary *)info;

/*!
 * @method httpClient:didFailedRequest:
 * @abstract
 *  TODO: write description ...
 * @discussion
 *  TODO: write description ...
 *
 * @param client A FWHttpClient object.
 * @param error A error.
 * @availability
 *  FWFoundatoin 0.1
 */
- (void)httpClient:(FWHttpClient *)client 
  didFailedRequest:(NSError *)error;
    
@end

