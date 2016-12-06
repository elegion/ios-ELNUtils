//
//  IndexPathsSelectableContainer.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import UIKit

protocol IndexPathsSelectionContainer {
    
    var selectedIndexPaths: [IndexPath]? { get }
    
    func select(indexPath: IndexPath, animated: Bool)
    
    func deselect(indexPath: IndexPath, animated: Bool)
    
}

extension IndexPathsSelectionContainer {

    public func deselectAll(animated: Bool) {
        selectedIndexPaths?.forEach({ deselect(indexPath: $0, animated: animated) })
    }

}

extension UITableView : IndexPathsSelectionContainer {
    
    var selectedIndexPaths: [IndexPath]? {
        return indexPathsForSelectedRows
    }
    
    public func select(indexPath: IndexPath, animated: Bool) {
        selectRow(at: indexPath, animated: animated, scrollPosition: .none)
    }
    
    public func deselect(indexPath: IndexPath, animated: Bool) {
        deselectRow(at: indexPath, animated: animated)
    }
    
}

extension UICollectionView : IndexPathsSelectionContainer {
    
    var selectedIndexPaths: [IndexPath]? {
        return indexPathsForSelectedItems
    }
    
    public func select(indexPath: IndexPath, animated: Bool) {
        selectItem(at: indexPath, animated: animated, scrollPosition: [])
    }
    
    public func deselect(indexPath: IndexPath, animated: Bool) {
        deselectItem(at: indexPath, animated: animated)
    }
    
}
