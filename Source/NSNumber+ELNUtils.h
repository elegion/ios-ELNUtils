//
//  NSNumber+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 30.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

@interface NSNumber (ELNUtils)

/// Returns a number of digits before floating point.
- (NSUInteger)eln_numberOfIntegerDigits;

- (CGFloat)CGFloatValue;

@end
