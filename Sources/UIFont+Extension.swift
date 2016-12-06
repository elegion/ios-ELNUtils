//
//  UIFont+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

public extension UIFont {
    
    public func eln_fontWithSymbolicTraits(_ transform: (inout UIFontDescriptorSymbolicTraits) -> ()) -> UIFont? {
        var symbolicTraits = fontDescriptor.symbolicTraits
        transform(&symbolicTraits)
        
        let descriptor = fontDescriptor.withSymbolicTraits(symbolicTraits)
        if let descriptor = descriptor {
            return UIFont(descriptor: descriptor, size: pointSize)
        } else {
            return nil
        }
    }
    
    public func eln_font(familyName: String) -> UIFont? {
        var attributes = fontDescriptor.withFamily(familyName).fontAttributes
        // remove usage font descriptor attribute
        attributes["NSCTFontUIUsageAttribute"] = nil
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
}
