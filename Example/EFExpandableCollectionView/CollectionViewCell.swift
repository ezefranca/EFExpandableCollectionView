//
//  CollectionViewCell.swift
//  POC-CollectionCell
//
//  Created by Ezequiel França on 19/09/17.
//  Copyright © 2017 Ezequiel França. All rights reserved.
//

import UIKit

open class CollectionViewCell: UICollectionViewCell {
    
    public var isExpanded = false
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open override func layoutSubviews() {
        
        setShadow()
    }
    
    func setShadow() {
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8.0
        layer.shouldRasterize = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

}
