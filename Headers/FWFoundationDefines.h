//   
//  FWFoundationDefines.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @const FWErrorDomain
 * @abstract
 *  This constant is the FWFoundatoin framework error domain.
 * @discussion
 *  TODO: write description ...
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
extern const NSString *FWErrorDomain;

/*!
 * @const FWNotImplementedException
 * @abstract
 *  This constant is the string of FWNotImplementedException.
 * @discussion
 *  TODO: write description ...
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
extern const NSString *FWNotImplementedException;


/*!
 * @typedef FWError
 * @abstract
 *  This constants is the FWFoundatoin error code.
 * @discussion
 *  TODO: write description ...
 *
 * @constant FWErrorUnknown The value of unknown error.
 * @constant FWErrorSuccess The value of success.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
typedef enum {
    FWErrorUnknown = -1,
    FWErrorSuccess = 0,
    FWErrorInternalException,
    FWErrorHTTPAccessError,
    FWErrorHTTP400BadRequest,
    FWErrorHTTP401NotAutorized,
    FWErrorHTTP403Forbidden,
    FWErrorHTTP404NotFound,
    FWErrorHTTP500InternalServerError,
    FWErrorHTTP502BadGateway,
    FWErrorHTTP503ServerUnavailable,
    FWErrorHTTPDownloadInvalidData,
    FWErrorInvalidOperation,
    FWErrorNotImageFormatData,
    FWErrorRegexPatternParseFailed,
} FWError;


/*!
 * @typedef FWHttpClientContentType
 * @abstract
 *  This constns is the HTTP content type.
 * @discussion
 *  TODO: write description ...
 *
 * @constant FWHttpClientContentTypeUnknown The value of unknown type.
 * @constant FWHttpClientContentTypeXml The value of xml type.
 * @constant FWHttpClientContentTypeHtml The value of html type.
 * @constant FWHttpClientContentTypeImage The value of image type.
 * @constant FWHttpClientContentTypeText The value of text type.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
typedef enum {
    FWHttpClientContentTypeUnknown = 0,
    FWHttpClientContentTypeXml,
    FWHttpClientContentTypeHtml,
    FWHttpClientContentTypeImage,
    FWHttpClientContentTypeText,
} FWHttpClientContentType;

