//
//  Error.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case custom(String)
    case other
    case badResponse
    case jsonDecode
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .badResponse:
            return "Bad response"
        case .jsonDecode:
            return "Can not decode data"
        case .custom(let message):
            return message
        }
    }
}
