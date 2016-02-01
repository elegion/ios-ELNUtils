//
//  NSArray+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 27.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (ELNUtils)

/// Returns the first object in the array passing the test.
- (ObjectType)eln_objectPassingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;
/// Returns object in the array passing the test considering specified options.
- (ObjectType)eln_objectWithOptions:(NSEnumerationOptions)options passingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/// Map objects to returned values, filter out those ones where nil is returned.
- (NSArray *)eln_map:(id (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

@end
