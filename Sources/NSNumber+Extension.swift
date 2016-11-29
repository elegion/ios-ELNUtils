//
//  NSNumber+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension NSNumber {
    
    /// Returns a number of digits before floating point.
    public var eln_numberOfIntegerDigits: UInt {
        let value = abs(intValue)
        if value == 0 {
            return 1
        } else {
            return UInt(log10(CGFloat(value)) + 1)
        }
    }
    
}
