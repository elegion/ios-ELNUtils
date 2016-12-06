//
//  CGGeometry+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    /// Returns CGSize which is constrainted to size by both width and height
    func eln_constrainted(size: CGSize) -> CGSize {
        return CGSize(width: min(size.width, width), height: min(size.height, height))
    }
    
    var eln_minimumDimension: CGFloat {
        return min(width, height)
    }
    
    var eln_ceil: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }
    
}

extension CGRect {
    
    var eln_center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
}
