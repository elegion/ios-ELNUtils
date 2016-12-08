//
//  UIView+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

public extension UIViewAutoresizing {
    
    public static var flexibleMargins: UIViewAutoresizing = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    
    public static var flexibleDimensions: UIViewAutoresizing = [.flexibleWidth, .flexibleHeight]
    
}

public extension UIView {
    
    public func eln_wobble() {
        eln_wobble(duration:0.25, amplitude:10, frequency:7)
    }
    
    private func eln_wobble(duration: TimeInterval, amplitude: Double, frequency: Double) {
        let fr = layer.value(forKeyPath: "position.x") as! NSNumber
        let values: [Double] = (0...100).map { i in
            let t = Double(i) / 100.0
            return fr.doubleValue + amplitude * (sin((Double.pi / 2) * t * frequency) / exp((Double.pi / 2) * t))
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = values
        animation.duration = duration
        layer.add(animation, forKey: "wobble")
    }
    
    public func eln_superView(with `class`: AnyClass?) -> UIView? {
        var view: UIView? = self
        
        while view?.superview != nil {
            view = view?.superview
            if let `class` = `class`, let _ = view?.isKind(of: `class`) {
                break
            }
        }
        
        return view == self ? nil : view
    }
    
}
