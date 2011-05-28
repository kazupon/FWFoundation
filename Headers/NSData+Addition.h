//   
//  NSData+Addition.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @category NSData(Addition)
 * @abstract
 *  This category is extended the NSData.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundatoin 0.1
 */
@interface NSData (Addition)

/*!
 * @method md5Hash
 * @abstract
 *  Calculate the md5 hash of this data using CC_MD5.
 * @discussion
 *  TODO: write description ...
 *
 * @result An encryped string by md5.
 * @availability
 *  FWFoundatoin 0.1
 */
- (NSString *)md5Hash;

/*!
 * @method sha1Hash
 * @abstract
 *  Calculate the md5 hash of this data using CC_SHA1.
 * @discussion
 *  TODO: write description ...
 * 
 * @result An encryped string by sha1.
 * @availability
 *  FWFoundatoin 0.1
 */
- (NSString *)sha1Hash;

@end

