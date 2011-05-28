//   
//  NSObject+Addition.h
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-28
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @category NSObject(Addition)
 * @abstract
 *  This category is extended the NSObject.
 * @discussion
 *
 * @availability
 *  FWFoundatoin 0.1
 */
@interface NSObject (Addition)

/*!
 * @method performToTarget:withSelector:withArguments:
 * @abstract
 *  Sends a message to the target object with an object as the arguments.
 * @discussion
 *  Attention: variable list not support !!
 *
 * @param target A target object.
 * @param selector A selector identifying the message to send.
 * @param firstArgument An object that is the first argument in some arguments.
 * @result An object that is the result of the message.
 * @availability
 *  FWFoundatoin 0.1
 */
+ (id)performToTarget:(id)target withSelector:(SEL)selector 
      withArguments:(id)firstArgument, ...;

/*!
 * @method performSelector:withObjets:
 * @abstract
 *  Sends a message to the receiver with an object as the arguments.
 * @discussion
 *  Attention: variable list not support !!
 *
 * @param selector A selector identifying the message to send.
 * @param firstObject An object that is the first object in some objects.
 * @result An object that is the result of the message.
 * @availability
 *  FWFoundatoin 0.1
 */
- (id)performSelector:(SEL)selector withObjets:(id)firstObject, ...;

@end

