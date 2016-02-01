//
//  NSNumber+ELNUtils.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 30.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "NSNumber+ELNUtils.h"

@implementation NSNumber (ELNUtils)

- (NSUInteger)eln_numberOfIntegerDigits {
    NSInteger value = ABS(self.integerValue);
    if (value == 0) {
        return 1;
    } else {
        return (NSUInteger)(log10(value) + 1);
    }
}

@end
