//
//  UIColor+ELNUtils.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 27.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "UIColor+ELNUtils.h"

@implementation UIColor (ELNUtils)

+ (UIColor *)eln_colorWithHex:(unsigned)hex {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.;
    CGFloat g = ((hex & 0xFF00) >> 8) / 255.;
    CGFloat b = (hex & 0xFF) / 255.;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (NSString *)eln_hex {
    CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r, g, b;
    
    if (colorSpace == kCGColorSpaceModelMonochrome) {
        r = components[0];
        g = components[0];
        b = components[0];
    } else {
        r = components[0];
        g = components[1];
        b = components[2];
    }
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}

+ (UIColor *)eln_colorWithHexString:(NSString *)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSAssert(hexString.length == 6, @"Wrong hex string length.");
    
    unsigned rgbHex;
    [[[NSScanner alloc] initWithString:hexString] scanHexInt:&rgbHex];
    return [UIColor eln_colorWithHex:rgbHex];
}

@end
