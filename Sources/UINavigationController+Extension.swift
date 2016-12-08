//
//  UINavigationController+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 08/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

extension UINavigationController {

    enum Transition {
        
        case none
        
        case `default`

        case fade
        
        var animated: Bool {
            return self != .none
        }
        
        var transition: CATransition? {
            switch self {
            case .none:
                return nil
            case .default:
                return nil
            case .fade:
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                transition.type = kCATransitionFade
                return transition
            }
        }
    }
    
    func eln_push(viewController: UIViewController, transition: Transition) {
        if let transition = transition.transition {
            view.layer.add(transition, forKey: nil)
        }
        pushViewController(viewController, animated: transition.animated)
    }

    func eln_popViewController(transition: Transition) {
        if let transition = transition.transition {
            view.layer.add(transition, forKey: nil)
        }
        popViewController(animated: transition.animated)
    }
    
}
