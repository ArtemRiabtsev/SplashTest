//
//  PhotoCollectionRouter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

class PhotoCollectionRouter: BaseRouter<PhotoCollectionViewController> {
    
}

extension PhotoCollectionRouter {
    func toDetailPhoto(_ urlString: String) {
        DispatchQueue.main.async { [weak self] in
            guard let detailPhotoViewController = instantiateViewController(from: .main, with: .detailPhoto) as? DetailPhotoViewController else { return }
            DetailPhotoConfigurator().configure(view: detailPhotoViewController, with: urlString)
            self?.view?.navigationController?.pushViewController(detailPhotoViewController, animated: true)
        }
    }
}
