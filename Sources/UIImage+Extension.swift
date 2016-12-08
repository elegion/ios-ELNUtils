//
//  UIImage+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit
import CoreGraphics

public extension UIImage {
    
    /// Create image with specified size using block for drawing content
    public static func eln_image(with size: CGSize, drawingBlock: ((CGRect, CGContext) -> Void)?) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let drawingRect = CGRect(origin: CGPoint.zero, size: size)
        
        if let drawingBlock = drawingBlock {
            drawingBlock(drawingRect, context)
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        return image
    }
    
    public static func eln_image(cornerRadius: CGFloat, fillColor: UIColor, strokeColor: UIColor? = nil, lineWidth: CGFloat = 1) -> UIImage? {
        let px = 1 / UIScreen.main.scale
        let width = cornerRadius * 2 + px
        let size = CGSize(width: width, height: width)
        return eln_image(with: size) { rect, context in
            fillColor.setFill()
            let path: UIBezierPath
            if let strokeColor = strokeColor {
                path = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth, dy: lineWidth), cornerRadius: cornerRadius)
                path.lineWidth = lineWidth
                strokeColor.setStroke()
                path.fill()
                path.stroke()
            } else {
                path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                path.fill()
            }
            }?.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    }
    
    /// Create 1x1 px transparent image with specified color.
    public static func eln_image(color: UIColor) -> UIImage? {
        return eln_image(with: CGSize(width: 1, height: 1)) { rect, context in
            color.setFill()
            UIBezierPath(rect: rect).fill()
        }
    }
    
}
