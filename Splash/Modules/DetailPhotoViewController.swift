//
//  DetailPhotoViewController.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {  
    @IBOutlet private weak var imageView: BWPImageView!
    var presenter: DetailPhotoPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    private func uiSetup() {
        imageView.loadImage(urlString: presenter?.urlString)
    }
}

extension DetailPhotoViewController: BaseView {
    
}
