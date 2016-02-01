//
//  UIFont+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 12.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0

#warning Replace UIFont factory helpers with `systemFontOfSize:weight:` methods.

#endif

@interface UIFont (ELNUtils)

+ (UIFont *)eln_semiboldSystemFontOfSize:(CGFloat)size;

+ (UIFont *)eln_mediumSystemFontOfSize:(CGFloat)size;

+ (UIFont *)eln_lightSystemFontOfSize:(CGFloat)size;

+ (UIFont *)eln_thinSystemFontOfSize:(CGFloat)size;

@end
