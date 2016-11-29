//
//  NSLocale+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension Locale {
    
    /// Return locale for main bundle's most preferred localization
    /// Often preferred localization language and current locale differs. So in order to properly format
    /// numbers and dates you should use this method to obtain user's current UI language.
    public static var eln_localeForPreferredLocalization: Locale {
        let preferredLocalization = Bundle.main.preferredLocalizations.first!
        return Locale(identifier: preferredLocalization)
    }
    
}
