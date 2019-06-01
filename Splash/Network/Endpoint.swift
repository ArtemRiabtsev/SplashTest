//
//  Endpoint.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
    var urlComponents: URLComponents { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.path = path
        urlComponents?.queryItems = urlParameters
        return urlComponents!
    }
    var request: URLRequest? {
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
enum UnsplashEndpoint: Endpoint {
    
    case photos(page: String)
    case search(query: String, page: String)
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .search:
            return "/search/photos"
        }
    }
    var urlParameters: [URLQueryItem] {
        let items = [URLQueryItem(name: "client_id", value: ACCESS_KEY),
                    URLQueryItem(name: "per_page", value: IMAGE_PER_PAGE)]
        switch self {
        case .photos(let page):
            let additionalItems = [URLQueryItem(name: "page", value: page)]
            return items + additionalItems
        case .search(let query, let page):
            let additionalItems = [URLQueryItem(name: "page", value: page),
                     URLQueryItem(name: "query", value: query)]
            return items + additionalItems
        }
    }
}
