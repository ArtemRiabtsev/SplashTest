//
//  LoadFooterView.swift
//  Splash
//
//  Created by Артем Рябцев on 6/2/19.
//  Copyright © 2019 Артем Рябцев. All rights reserved.
//

import UIKit

class LoadFooterView: UICollectionReusableView {

    static let viewIdentifier = "LoadFooterView"
    
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    var isAnimatingFinal: Bool = false
    var currentTransform: CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTransform(inTransform: CGAffineTransform, scaleFactor: CGFloat) {
        if isAnimatingFinal {
            return
        }
        currentTransform = inTransform
        refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
        refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimate() {
        isAnimatingFinal = true
        refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
    
}
