//   
//  NSBundle+Addition.m
//  FWFoundation
//  
//  Created by kazuya kawaguchi on 2011-05-29
//  Copyright 2011 kazuya kawaguchi & frapwings All rights reserved.
//  

#import "NSBundle+Addition.h"


@implementation NSBundle (Addition)


+ (NSBundle *)bundleFromMainBundleRelativePath:(NSString *)bundlePath {
    DEBUG(@"bundleFromMainBundleRelativePath:%@", bundlePath);
    
    NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];
    INFO(@"mainBundlePath : %@", mainBundlePath);

    return [NSBundle bundleWithPath:
                [mainBundlePath stringByAppendingPathComponent:bundlePath]];
}


@end

