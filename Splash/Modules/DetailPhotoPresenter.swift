//
//  DetailPhotoPresenter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

protocol DetailPhotoPresenter {
    var urlString: String? { get set }
    func printCuctom()
}

class DetailPhotoPresenterImpl: BasePresenter<DetailPhotoViewController, DetailPhotoRouter> {
    var urlString: String?
}

extension DetailPhotoPresenterImpl: DetailPhotoPresenter {
    func printCuctom() {
        print("SOMEPRINT")
    }
}
