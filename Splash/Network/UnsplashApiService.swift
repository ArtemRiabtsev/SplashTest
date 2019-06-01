//
//  UnsplashNetworkService.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

class UnsplashApiServise: NetworkService {
    func get(_ endpoint: UnsplashEndpoint, completion: @escaping (Either<Images>) -> Void) {
        guard let request = endpoint.request else { return }
        load(request, completion: completion)
    }
    func search(_ endpoint: UnsplashEndpoint, completion: @escaping (Either<SearchObject>) -> Void) {
        guard let request = endpoint.request else { return }
        load(request, completion: completion)
    }
}
