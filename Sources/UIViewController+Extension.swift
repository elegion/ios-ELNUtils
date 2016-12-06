//
//  UIViewController+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func eln_addChildViewController(_ childController: UIViewController, addSubviewHandler: () -> ()) {
        addChildViewController(childController)
        addSubviewHandler()
        childController.didMove(toParentViewController: self)
    }
    
    func eln_removeFromParentViewController() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
}
