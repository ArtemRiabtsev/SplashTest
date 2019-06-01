//
//  PhotoCollectionConfigurator.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

class PhotoCollectionConfigurator: BaseConfigurator<PhotoCollectionViewController, PhotoCollectionRouter, PhotoCollectionPresenterImpl> {
    
    func configure(view: PhotoCollectionViewController, with images: Images) {
        let presenter = super.configure(view: view)
        presenter.images = images
    }
}
