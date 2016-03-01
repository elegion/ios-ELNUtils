//
//  UIView+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 13.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import UIKit;

@interface UIView (ELNUtils)

- (void)eln_wobble;

- (__kindof UIView *)eln_superviewWithClass:(Class)superviewClass;

+ (instancetype)eln_viewFromNibInBundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options;

+ (instancetype)eln_viewFromNibInBundle:(NSBundle *)bundle;

@end
