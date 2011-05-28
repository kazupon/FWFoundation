//   
//  NSDictionary+Addition.h
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2010-12-09.
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @category NSDictionary(Addition)
 * @abstract
 *  This category is extended in NSDictionary.
 * @discussion
 *  TODO: wirte description ...
 *
 * @availability
 *  FWFoundatoin 0.1
 */
@interface NSDictionary (Addition)

/*!
 * @method isExist
 * @abstract
 *  Check the key exisits in dicitionary.
 * @discussion
 *  TODO: wirte description ...
 *
 * @param key The key.
 * @result YES or NO.
 * @availability
 *  FWFoundatoin 0.1
 */
- (BOOL)isExist:(id)key;

@end

