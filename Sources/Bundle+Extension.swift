//
//  Bundle+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension Bundle {

    private enum InfoDictionaryKey : String {
        
        case urlTypes = "CFBundleURLTypes"
        
        case urlSchemes = "CFBundleURLSchemes"
        
        case shortVersionString = "CFBundleShortVersionString"
        
        case displayName = "CFBundleDisplayName"
        
        case name = "CFBundleName"
        
    }
   
    public func eln_objectForInfoDictionary<T>(keyPath: String) -> T? {
        return (infoDictionary as NSDictionary?)?.value(forKeyPath: keyPath) as? T
    }
    
    /// Returns a union of CFBundleURLSchemes values declared in bundle's plist.
    public var eln_urlSchemes: [Any]?  {
        let keyPath = "\(InfoDictionaryKey.urlTypes).@unionOfArrays.\(InfoDictionaryKey.urlSchemes)"
        let value = (infoDictionary as NSDictionary?)?.value(forKeyPath: keyPath) as? [Any]
        return value
    }

    /// Returns a value for kCFBundleVersionKey key decalred in bundle's plist.
    public var eln_version: String?  {
        return infoDictionary?[kCFBundleVersionKey as String] as? String
    }

    /// Returns a value for CFBundleShortVersionString key declared in bundle's plist.
    public var eln_shortVersion: String? {
        return infoDictionary?[InfoDictionaryKey.shortVersionString.rawValue] as? String
    }

    public var eln_displayName: String? {
        return infoDictionary?[InfoDictionaryKey.displayName.rawValue] as? String
    }

    public var eln_name: String? {
        return infoDictionary?[InfoDictionaryKey.name.rawValue] as? String
    }
    
}
