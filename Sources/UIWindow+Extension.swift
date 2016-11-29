//
//  UIWindow+ELNUtils.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 29/11/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

extension UIWindow {
    
    enum RootViewControllerTransitionAnimation {
        
        case none
        
        case flipFromLeft
        
        case flipFromRight
        
        case crossDissolve

    }
    
    /**
     Replaces root view controller with specified animation.
     Often used by the auth <-> main screens transition.
     */
    func eln_replaceRootViewController(with viewController: UIViewController, animation: RootViewControllerTransitionAnimation, completion: (Bool) -> Void) {
        
    }
    
}
