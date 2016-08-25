//
//  NSSortDescriptor+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 19.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSSortDescriptor (ELNUtils)

/**
 Returns an array of the NSSortDescripor instances
 
 @param string Formatted string. For example string "title,-description" becomes "title ASC, description DESC"
 */
+ (nullable NSArray *)eln_sortDescriptorsFromString:(nullable NSString *)string;

@end

NS_ASSUME_NONNULL_END
