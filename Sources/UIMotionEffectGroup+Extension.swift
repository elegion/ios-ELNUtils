//
//  UIMotionEffectGroup+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

public extension UIMotionEffectGroup {

    public convenience init(offset: UIOffset) {
        self.init()

        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -offset.horizontal
        horizontal.maximumRelativeValue = offset.horizontal
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -offset.vertical
        vertical.maximumRelativeValue = offset.vertical
        
        motionEffects = [horizontal, vertical]
    }

}
