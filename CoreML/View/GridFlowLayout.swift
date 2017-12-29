//
//  GridFlowLayout.swift
//  CoreML
//
//  Created by Eugene on 2017-12-29.
//  Copyright © 2017 Eugene. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        minimumLineSpacing = 1.0
        minimumInteritemSpacing = 1.0
        scrollDirection = .vertical
        
    }
    
    override var itemSize: CGSize {
        set {}
        get {
            let numberOfColums: CGFloat = 3
            let itemWidth = ((self.collectionView?.frame.width ?? 0
                ) - (numberOfColums - 1))/numberOfColums
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
