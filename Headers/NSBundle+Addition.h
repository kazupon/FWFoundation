//   
//  NSBundle+Addtion.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @category NSBundle (Addition)
 * @abstract
 *  This category is extended the NSBundle.
 * @discussion
 *  TODO: write description ...
 *
 * @availability
 *  FWFoundation 0.1
 */
@interface NSBundle (Addition)

/*!
 * @method bundleFromMainBundleRelativePath:
 * @abstract
 *  Get a bundle from main bundle of releative path.
 * @discussion
 *  TODO: write description ...
 *
 * @result A bundle.
 * @availability
 *  FWFoundation 0.1
 */
+ (NSBundle *)bundleFromMainBundleRelativePath:(NSString *)bundlePath;

@end

