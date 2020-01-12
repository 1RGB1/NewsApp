//
//  UIViewExtenstion.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerByValue(cornerRadius : Bool , value : CGFloat)  {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius ? self.frame.size.height/value : 0
    }
    
    func addShadow(color: UIColor = .lightGray, opacity: Float = 0.8, radius: CGFloat = 0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    func addBorder(color: UIColor = .black, width: CGFloat = 2) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}
