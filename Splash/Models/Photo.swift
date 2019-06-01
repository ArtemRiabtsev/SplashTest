//
//  File.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

import UIKit

typealias Images = [Photo]

struct Photo: Codable  {
    let id: String
    let likes: Int
    let urls: URLS
}
