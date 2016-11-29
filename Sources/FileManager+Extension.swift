//
//  FileManager+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension FileManager {
    
    /// Creates a specified directory in a specified domain by appending path component
    public func eln_url(for directory: FileManager.SearchPathDirectory, in domain: FileManager.SearchPathDomainMask, append pathComponent: String?, create:Bool) throws -> URL {
        let rootDirectory: URL = try self.url(for: directory, in: domain, appropriateFor: nil, create: create)

        var url = rootDirectory
        if let pathComponent = pathComponent  {
            url = url.appendingPathComponent(pathComponent)
        }

        if create, !fileExists(atPath: url.path) {
            try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return url
    }
    
}
