//
//  UIViewController.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

func instantiateViewController(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) -> UIViewController {
    let _storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return _storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
}

extension UIViewController {
    func presentViewController(from storyboard: UIIdentifier.Storyboard, with identifier: UIIdentifier.ViewController) {
        present(instantiateViewController(from: storyboard, with: identifier), animated: true, completion: nil)
    }
}
