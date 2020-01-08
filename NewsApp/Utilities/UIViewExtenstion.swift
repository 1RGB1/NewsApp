//
//  UIViewExtenstion.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
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
}
