//
//  DetailPhotoConfigurator.swift
//  Splash
//
//  Created by Артем Рябцев on 6/2/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

class DetailPhotoConfigurator: BaseConfigurator<DetailPhotoViewController, DetailPhotoRouter, DetailPhotoPresenterImpl> {
    
    func configure(view: DetailPhotoViewController, with urlString: String) {
        let presenter = super.configure(view: view)
        presenter.urlString = urlString
    }
}
