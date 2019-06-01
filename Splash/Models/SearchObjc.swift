//
//  SearchObjc.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

struct SearchObject: Codable {
    let total: Int
    let total_pages: Int
    let results: Images
}
