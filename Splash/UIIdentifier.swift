//
//  UIIdentifier.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import Foundation

enum UIIdentifier {
    enum Storyboard: String {
        case main = "Main"
    }
    
    enum ViewController: String {
        case photoCollection = "PhotoCollectionViewController"
        case detailPhoto = "DetailPhotoViewController"
    }
}
