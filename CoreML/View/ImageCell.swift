//
//  ImageCellCollectionViewCell.swift
//  CoreML
//
//  Created by Eugene on 2017-12-28.
//  Copyright © 2017 Eugene. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(_ image: UIImage) {
        imageView.image = image
    }
}
