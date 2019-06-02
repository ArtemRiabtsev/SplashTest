//
//  CollectionViewCell.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let cellId = "CollectionViewCell"
    @IBOutlet private weak var imageView: BWPImageView!
    var urlString: String = "" {
        didSet {
            imageView.loadImage(urlString: urlString)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
