//
//  EFExpandableCollectionViewController.swift
//  EFExpandableCollectionView
//
//  Created by Ezequiel França on 19/09/17.
//  Copyright © 2017 Ezequiel França. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(where: { $0 == object }) {
            remove(at: index)
        }
    }
}

public protocol EFExpandableCollectionViewDelegate {
    
    func expandableCollectionViewController(numberOfSections in: UICollectionView?) -> Int
    func expandableCollectionViewController(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int
    func expandableCollectionViewController(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func expandableCollectionViewController(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func expandableCollectionViewController(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath, isExpanded:Bool) -> CGSize
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat
    func expandableCollectionViewController(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat
    
    func expandableAllCells(_ collectionView: UICollectionView)
    func collapseAllCells(_ collectionView: UICollectionView)
}

public extension EFExpandableCollectionViewDelegate {
    func expandableAllCells(_ collectionView: UICollectionView) {}
    func collapseAllCells(_ collectionView: UICollectionView) {}
}

public class EFExpandableCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var _expandedsIndexPath : [IndexPath] = []
    
    public var delegate: EFExpandableCollectionViewDelegate? {
        didSet {
            self.collectionView?.dataSource = self
            self.collectionView?.delegate = self
            self.collectionView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
    }
    
    public var expandedsIndexPaths: [IndexPath] {
        get {
            return _expandedsIndexPath
        }
    }
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let _delegate = delegate else { return 0 }
        return _delegate.expandableCollectionViewController(numberOfSections: collectionView)
    }
    
    override public func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let _delegate = delegate else { return 0 }
        return _delegate.expandableCollectionViewController(collectionView, numberOfItemsInSection: section)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let _delegate = delegate else { return UICollectionViewCell() }
        
        if _expandedsIndexPath.contains(indexPath) {
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
        return _delegate.expandableCollectionViewController(collectionView, cellForItemAt: indexPath)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let _delegate = delegate else { return }
        
        cell.layoutSubviews()
        if _expandedsIndexPath.contains(indexPath) {
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
        _delegate.expandableCollectionViewController(collectionView, willDisplay: cell, forItemAt: indexPath)
        
    }
    
    private func lastIndexPath(collectionView: UICollectionView) -> IndexPath? {
        
        for sectionIndex in (0..<collectionView.numberOfSections).reversed() {
            if collectionView.numberOfItems(inSection: sectionIndex) > 0 {
                return IndexPath.init(item: collectionView.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex)
            }
        }
        
        return nil
    }
    
    private func scroolToBottom(_ collectionView: UICollectionView, index: IndexPath) {
        collectionView.scrollToItem(at: index, at: UICollectionViewScrollPosition.bottom, animated: true)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let _delegate = delegate else { return }
        
        if indexPath == self.lastIndexPath(collectionView: collectionView) {
            self.scroolToBottom(collectionView, index: indexPath)
        }
        
        if _expandedsIndexPath.contains(indexPath) { _expandedsIndexPath.remove(indexPath) }
        else { _expandedsIndexPath.append(indexPath) }
        
        collectionView.performBatchUpdates({
            collectionView.collectionViewLayout.invalidateLayout()
        }) { (finish) in
            _delegate.expandableCollectionViewController(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let _delegate = delegate else { return CGSize(width: view.frame.size.width * 0, height: view.frame.size.width * 0) }
        return _delegate.expandableCollectionViewController(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath, isExpanded: _expandedsIndexPath.contains(indexPath))
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let _delegate = delegate else { return 0.0 }
        return _delegate.expandableCollectionViewController(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        
        guard let _delegate = delegate else { return 0.0 }
        return _delegate.expandableCollectionViewController(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
    }
}
