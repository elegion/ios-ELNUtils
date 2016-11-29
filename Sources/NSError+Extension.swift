//
//  NSError+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension NSError {

    private func eln_matchesDomain(_ domain: String, codes: [Int]) -> Bool {
        return domain == domain && codes.contains(code)
    }

    public var eln_isUrlConnectionError: Bool {
        let codes = [NSURLErrorTimedOut,
                     NSURLErrorCannotFindHost,
                     NSURLErrorCannotConnectToHost,
                     NSURLErrorNetworkConnectionLost,
                     NSURLErrorDNSLookupFailed,
                     NSURLErrorNotConnectedToInternet,
                     NSURLErrorInternationalRoamingOff,
                     NSURLErrorCallIsActive,
                     NSURLErrorDataNotAllowed]
        
        if eln_matchesDomain(NSURLErrorDomain, codes: codes) {
            return true
        } else if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
            return underlyingError.eln_isUrlConnectionError
        }
        
        return false
    }

    public var eln_isUrlConnectionCancelledError: Bool {
        return eln_matchesDomain(NSURLErrorDomain, codes: [NSURLErrorCancelled])
    }
    
}
