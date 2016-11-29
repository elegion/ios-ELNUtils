//
//  NSString+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

public extension NSString {
    
    public func eln_boundingRect(size: CGSize, font: UIFont?, lineBreakMode: NSLineBreakMode, numberOfLines: Int) -> CGRect {
        var attributes: [String: Any] = [:]

        // font
        if let font = font {
            attributes[NSFontAttributeName] = font
        }
        
        // linebreak mode
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = lineBreakMode
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        
        // options
        let options: NSStringDrawingOptions = numberOfLines != 1 ? .usesLineFragmentOrigin : .truncatesLastVisibleLine
        
        var rect = boundingRect(with: size, options: options, attributes: attributes, context: nil)
        rect.size.width = ceil(rect.size.width)
        rect.size.height = ceil(rect.size.height)
        
        return rect
    }
    
    /// Returns an NSString object initialized by using a given format string as a template into which the remaining argument values are substituted according to given locale information.
    ///
    /// Fixes iOS9 compatibility.
    ///
    /// - See: http://maniak-dobrii.com/understanding-ios-internationalization/
    public func eln_localizedStringWithFormat(_ format: NSString, _ args: CVarArg...) -> NSString {
        let locale = Locale.eln_localeForPreferredLocalization
        return NSString(format: format, locale: locale, args)
    }

}
