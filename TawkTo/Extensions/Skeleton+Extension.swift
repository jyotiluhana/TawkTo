//
//  Skeleton+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation
import UIKit

extension UIView {
    
    class ShimmerLoader {
        var gradientLayer : CAGradientLayer
        var animation     : CABasicAnimation
        
        init(gradientLayer : CAGradientLayer,animation : CABasicAnimation) {
            self.gradientLayer = gradientLayer
            self.animation = animation
        }
    }
    
    @discardableResult
    func addShimmerLoading()-> ShimmerLoader {
        
        func setFrame(ofLayer gradientLayer : CAGradientLayer,animation : CABasicAnimation){
            if self.bounds == .zero {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    setFrame(ofLayer: gradientLayer, animation: animation)
                }
            }else{
                gradientLayer.frame = self.bounds
                gradientLayer.add(animation, forKey: animation.keyPath)
            }
        }

        let gradientColorOne : CGColor = UIColor(white: 0.80, alpha: 1.0).cgColor
        let gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        
        
        let gradientLayer = CAGradientLayer()
                
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        self.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        animation.duration = 1.5
        
        
        setFrame(ofLayer: gradientLayer,animation : animation)
        
        return ShimmerLoader(gradientLayer: gradientLayer, animation: animation)
    }
    
    func removeShimmer(loader : ShimmerLoader?) {
        guard let loader = loader else { return }
        loader.gradientLayer.removeAllAnimations()
        loader.gradientLayer.removeFromSuperlayer()
    }

}

