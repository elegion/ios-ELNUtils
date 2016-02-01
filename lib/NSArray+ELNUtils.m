//
//  NSArray+ELNUtils.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 27.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "NSArray+ELNUtils.h"

@implementation NSArray (ELNUtils)

- (id)eln_objectPassingTest:(BOOL (^)(id, NSUInteger, BOOL *))predicate {
    return [self eln_objectWithOptions:0 passingTest:predicate];
}

- (id)eln_objectWithOptions:(NSEnumerationOptions)options passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    NSUInteger index = [self indexOfObjectWithOptions:options passingTest:predicate];
    if (index == NSNotFound) {
        return nil;
    } else {
        return self[index];
    }
}

- (NSArray *)eln_map:(id (^)(id obj, NSUInteger index, BOOL *stop))predicate {
    if (predicate == nil) {
        return nil;
    }

    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger i = 0; i < self.count; i++) {
        BOOL stop = NO;
        id obj = predicate(self[i], i, &stop);
        if (obj != nil) {
            [result addObject:obj];
        }
        
        if (stop) {
            return [result copy];
        }
    }
    return [result copy];
}

@end
