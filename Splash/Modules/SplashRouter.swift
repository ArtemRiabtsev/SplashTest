//
//  SplashRouter.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

class SplashRouter: BaseRouter<SplashViewController> {
    
}

extension SplashRouter {
    func toPhotoCollection(_ images: Images) {
        DispatchQueue.main.async { [weak self] in
            guard let photoCollectionViewController = instantiateViewController(from: .main, with: .photoCollection) as? PhotoCollectionViewController else { return }
            PhotoCollectionConfigurator().configure(view: photoCollectionViewController, with: images)
            self?.view?.navigationController?.pushViewController(photoCollectionViewController, animated: true)
        }
    }
}
