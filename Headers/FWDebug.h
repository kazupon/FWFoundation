//   
//  FWDebug.h
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-28
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import <Foundation/Foundation.h>

/*!
 * @defined FW_DEBUG_LEVEL_ERROR
 * @abstract
 *  This macro is the FWFoundatoin framework debug console error level.
 * @discussion
 *  TODO write description.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#define FW_DEBUG_LEVEL_ERROR    1

/*!
 * @defined FW_DEBUG_LEVEL_WARN
 * @abstract
 *  This macro is the FWFoundatoin framework debug console warning level.
 * @discussion
 *  TODO write description.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#define FW_DEBUG_LEVEL_WARN     3

/*!
 * @defined FW_DEBUG_LEVEL_INFO
 * @abstract
 *  This macro is the FWFoundatoin framework debug console infomation level.
 * @discussion
 *  TODO write description.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#define FW_DEBUG_LEVEL_INFO     5

/*!
 * @defined FW_DEBUG_LEVEL_DEBUG
 * @abstract
 *  This macro is the FWFoundatoin framework debug console debug level.
 * @discussion
 *  TODO write description.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#define FW_DEBUG_LEVEL_DEBUG    7


/*!
 * @defined FW_DEBUG_LEVEL
 * @abstract
 *  This macro is the printing message to debug console.
 * @discussion
 *  TODO write description.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#ifndef FW_DEBUG_LEVEL
    #define FW_DEBUG_LEVEL FW_DEBUG_LEVEL_ERROR
#endif

/*!
 * @defined _LOG
 * @abstract
 *  This macro is private macro.
 * @parseOnly
 */ 
#define _LOG(format, ...) \
    NSLog(format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
    __LINE__, ##__VA_ARGS__)


/*!
 * @defined FW_DEBUG
 * @abstract
 *  This macro is printing debug message to debug console.
 * @discussion
 *  TODO write description.
 *
 * @param format The message format.
 * @param ... The arguments.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#ifdef FW_DEBUG_LEVEL
    #if FW_DEBUG_LEVEL >= FW_DEBUG_LEVEL_DEBUG
        #define FW_DEBUG(format, ...) _LOG((@"D %@(%d) : " format), ##__VA_ARGS__)
    #else
        #define FW_DEBUG(format, ...)  ;
    #endif
#endif

/*!
 * @defined FW_INFO
 * @abstract
 *  This macro is printing debug message to debug console.
 * @discussion
 *  TODO write description.
 *  
 * @param format The message format.
 * @param ... The arguments.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#ifdef FW_DEBUG_LEVEL
    #if FW_DEBUG_LEVEL >= FW_DEBUG_LEVEL_INFO
        #define FW_INFO(format, ...) _LOG((@"I %@(%d) : " format), ##__VA_ARGS__)
    #else
        #define FW_INFO(format, ...)  ;
    #endif
#endif

/*!
 * @defined FW_WARN
 * @abstract
 *  This macro is printing debug message to debug console.
 * @discussion
 *  TODO write description.
 *  
 * @param format The message format.
 * @param ... The arguments.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#ifdef FW_DEBUG_LEVEL
    #if FW_DEBUG_LEVEL >= FW_DEBUG_LEVEL_WARN
        #define FW_WARN(format, ...) _LOG((@"W %@(%d) : " format), ##__VA_ARGS__)
    #else
        #define FW_WARN(format, ...)  ;
    #endif
#endif

/*!
 * @defined FW_ERROR
 * @abstract
 *  This macro is printing debug message to debug console.
 * @discussion
 *  TODO write description.
 *  
 * @param format The message format.
 * @param ... The arguments.
 * 
 * @availability
 *  FWFoundatoin 0.1
 */
#ifdef FW_DEBUG_LEVEL
    #if FW_DEBUG_LEVEL >= FW_DEBUG_LEVEL_ERROR
        #define FW_ERROR(format, ...) _LOG((@"E %@(%d) : " format), ##__VA_ARGS__)
    #else
        #define FW_ERROR(format, ...)  ;
    #endif
#endif

