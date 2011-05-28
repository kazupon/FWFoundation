//   
//  NSObject+Addition.m
//  FWFoundatoin
//  
//  Created by kazuya kawaguchi on 2011-05-28
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSObject+Addition.h"
#import <stdarg.h>


@implementation NSObject (Addition)

// TODO should be implemented !!
+ (id)performToTarget:(id)target withSelector:(SEL)selector 
      withArguments:(id)firstArgument, ... {
    DEBUG(@"performToTarget:%@ withSelector:%@ withArguments:%p", 
          target, NSStringFromSelector(selector));
    NSAssert(target != nil, nil);
    NSAssert(selector != nil, nil);

    va_list arugmentList;
    va_start(arugmentList, firstArgument);
    
    id result = objc_msgSend(target, selector, firstArgument, arugmentList);
    INFO(@"result : %p", result);

    va_end(arugmentList);
    
    return result;
    
    /*
    NSMethodSignature *signature = 
      [[target class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = 
          [NSInvocation invocationWithMethodSignature:signature];
    unsigned int length = [signature methodReturnLength];
    INFO(@"frame length = %d", [signature frameLength]);
    INFO(@"number of arugments = %d", [signature numberOfArguments]);
    INFO(@"return length = %d", length);

    // set selector & target.
    [invocation setSelector:selector];
    [invocation setTarget:target];

    // set arguments.
    if (firstArgument) {
        [invocation setArgument:firstArgument atIndex:index];
        index++; 
        va_list arugmentList;
        va_start(arugmentList, firstArgument);
        void *arg;
        while((arg = va_arg(arugmentList, void *))) {
            DEBUG(@"index : %d", index);
            [invocation setArgument:arg atIndex:index];
            index++;
        }
        va_end(arugmentList);
    }

    // invoke !!
    [invocation invoke];

    // get result.
    id result = nil; 
    if ([signature methodReturnLength]) {
        [invocation getReturnValue:&result];
    }
    //[invocation getReturnValue:&result];
    INFO(@"result : %p", result);

    return result;
 */
}

// TODO should be implemented !!
- (id)performSelector:(SEL)selector withObjets:(id)firstObject, ... {
    DEBUG(@"performSelector:%@ withObjets:%p",
          NSStringFromSelector(selector), firstObject);

    /*
    va_list objectList;
    va_start(objectList, firstObject);
    
    id result = objc_msgSend(self, selector, firstObject, objectList);
    //id result = [NSObject performToTarget:self withSelector:selector 
    //                        withArguments:firstObject, objectList];
    INFO(@"result : %p", result);

    va_end(objectList);

    return result;
    */
    return nil;
}


@end
