//
//  ViewController.swift
//  Splash
//
//  Created by Артем Рябцев on 6/1/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    var presenter: SplashPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BaseConfigurator<SplashViewController, SplashRouter, SplashPresenterImpl>().configure(view: self)
        presenter?.load()
    }
}

extension SplashViewController: BaseView {
    
}
