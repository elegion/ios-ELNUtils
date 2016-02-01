//
//  UIColor+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 27.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ELNUtils)

+ (UIColor *)eln_colorWithHex:(unsigned)hex;
+ (UIColor *)eln_colorWithHexString:(NSString *)hexString;

@end
