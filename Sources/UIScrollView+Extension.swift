//
//  UIScrollView+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    /// Safely adds refresh control to the table view.
    ///
    ///  If you are not using UITableViewController and use to add UIRefreshControl directly to the UITableView
    ///  by calling `addSubview:`, than you probably should know about a bug when the table view is "jumping"
    ///  when the refresh control is changing table view's content inset. There are two ways to avoid the bug.
    ///  First is to override `setContentInset:`, for details see the link below.
    ///  Second is to setup refresh control using table view's private property.
    ///
    /// - See http://stackoverflow.com/questions/19483511/uirefreshcontrol-with-uicollectionview-in-ios7
    func eln_setRefreshControl(_ refreshControl: UIRefreshControl) {
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            let selector = NSString(format: "_set%@", "RefreshControl") as String
            perform(Selector(selector), with: refreshControl)
        }
    }
    
}
