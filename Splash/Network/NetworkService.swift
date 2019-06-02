//
//  NetworkService.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

enum Either<T> {
    case success(T)
    case error(ServiceError)
}

protocol NetworkService {
    func load<T: Codable>(_ request: URLRequest, completion: @escaping (Either<T>) -> Void)
}

extension NetworkService {
    var session: URLSession { return URLSession.shared }
    
    func load<T: Codable>(_ request: URLRequest, completion: @escaping (Either<T>) -> Void) {
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.error(.custom(error.localizedDescription)))
            }
            do {
                guard let data = data else { return }
                let value = try JSONDecoder().decode(T.self, from: data)
                
                completion(Either.success(value))
            } catch {
                completion(.error(.jsonDecode))
            }
        }.resume()
    }
}
