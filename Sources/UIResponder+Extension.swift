//
//  UIResponder+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

fileprivate weak var currentFirstResponder: UIResponder?

extension UIResponder {
    
    static var eln_currentFirstResponder: UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(eln_findFirstResponder), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    @objc private func eln_findFirstResponder(sender: Any) {
        currentFirstResponder = self
    }
    
}
