//
//  PhotoCollectionPresenter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

protocol PhotoCollectionPresenter {
    var images: Images { get set }
    func configur(_ cell: CollectionViewCell, with index: Int)
    func load()
    func search(_ query: String)
    func pageRefresh()
    func itemPressed(_ item: Int)
}

class PhotoCollectionPresenterImpl: BasePresenter<PhotoCollectionViewController, PhotoCollectionRouter> {
    var images = Images()
    private let unsplashService = UnsplashApiServise()
    private var currentPage: Int = 1
    private func incrementPage() {
        currentPage += 1
    }
}

extension PhotoCollectionPresenterImpl: PhotoCollectionPresenter {
    
    func configur(_ cell: CollectionViewCell, with index: Int) {
        let photo = images[index]
        cell.urlString = photo.urls.small?.absoluteString ?? ""
    }
    func load() {
        incrementPage()
        if currentPage > MAX_PAGE {
            view?.showError(title: nil, message: "No pages available", okAction: nil)
        }
        let endpoint = UnsplashEndpoint.photos(page: String(currentPage))
        unsplashService.get(endpoint) { [weak self] either in
            switch either {
            case .success(let images):
                self?.images.append(contentsOf: images)
                self?.view?.imagesDidLoad()
            case .error(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(title: nil, message: error.errorDescription, okAction: nil)
                }
            }
        }
    }
    
    func search(_ query: String) {
        let endpoint = UnsplashEndpoint.search(query: query, page: String(currentPage))
        unsplashService.search(endpoint) { [weak self] either in
            switch either {
            case .success(let images):
                self?.images.append(contentsOf: images.results)
                self?.view?.imagesDidLoad()
            case .error(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(title: nil, message: error.errorDescription, okAction: nil)
                }
            }
        }
        incrementPage()
    }
    
    func pageRefresh() {
        currentPage = 1
        images.removeAll()
    }
    
    func itemPressed(_ item: Int) {
        let photo = images[item]
        let urlString = photo.urls.raw?.absoluteString ?? ""
        router?.toDetailPhoto(urlString)
    }
}
