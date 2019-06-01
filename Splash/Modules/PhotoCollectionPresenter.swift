//
//  PhotoCollectionPresenter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

protocol PhotoCollectionPresenter {
    var images: Images? { get set }
    func configur(_ cell: CollectionViewCell, with index: Int)
}

class PhotoCollectionPresenterImpl: BasePresenter<PhotoCollectionViewController, PhotoCollectionRouter> {
    var images: Images?
}

extension PhotoCollectionPresenterImpl: PhotoCollectionPresenter {
    func configur(_ cell: CollectionViewCell, with index: Int) {
        let photo = images?[index]
        cell.urlString = photo?.urls.small.absoluteString ?? ""
    }
}
