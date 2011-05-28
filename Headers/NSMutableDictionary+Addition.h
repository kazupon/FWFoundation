//   
//  NSMutableDictionary+Addition.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @category NSMutableDictionary(Addition)
 * @abstract
 *  This category is extended in NSMutableDictionary.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundation 0.1
 */
@interface NSMutableDictionary (Addition)

/*!
 * @method isExist
 * @abstract
 *  Check the key exisits in dicitionary.
 * @discussion
 *  TODO: write description ...
 *
 * @param key The key.
 * @result YES or NO.
 * @availability
 *  FWFoundation 0.1
 */
- (BOOL)isExist:(id)key;

@end

