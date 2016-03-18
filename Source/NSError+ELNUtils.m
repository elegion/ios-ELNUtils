//
//  NSError+ELNUtils.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 05.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "NSError+ELNUtils.h"

@implementation NSError (ELNUtils)

- (BOOL)eln_isNetworkError {
    if ([self.domain isEqualToString:NSURLErrorDomain]) {
        switch (self.code) {
            case NSURLErrorTimedOut:
            case NSURLErrorCannotFindHost:
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorNetworkConnectionLost:
            case NSURLErrorDNSLookupFailed:
            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorInternationalRoamingOff:
            case NSURLErrorCallIsActive:
            case NSURLErrorDataNotAllowed:
                return YES;
        }
    }
    NSError *underlyingError = self.userInfo[NSUnderlyingErrorKey];
    return underlyingError.eln_isNetworkError;
}

@end
