//
//  NSError+ELNUtils.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 05.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;

@interface NSError (ELNUtils)

@property (nonatomic, readonly) BOOL eln_isNetworkError;

@end
