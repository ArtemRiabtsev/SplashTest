//
//  SplashPresenter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

protocol SplashPresenter {
    func load()
}

class SplashPresenterImpl: BasePresenter<SplashViewController, SplashRouter> {
    private let unsplashService = UnsplashApiServise()
}

extension SplashPresenterImpl: SplashPresenter {
    func load() {
        let endpoint = UnsplashEndpoint.photos(page: "1")
        unsplashService.get(endpoint) { [weak self] either in
            switch either {
            case .success(let images):
                self?.router?.toPhotoCollection(images)
            case .error(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(title: nil, message: error.errorDescription, okAction: nil)
                }
            }
        }
    }
}
