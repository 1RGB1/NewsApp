//
//  Utilities.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/7/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation
import SVProgressHUD

class Utilities {
    class func showProgressHUDWithSuccess(_ status: String) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            SVProgressHUD.showSuccess(withStatus: status)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    class func showProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    class func showProgressHUDWithError(_ error: String) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            SVProgressHUD.showError(withStatus: error)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    class func dismissProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    class func setImage(_ imageView: UIImageView, _ imageURL: String) {
        let url = URL(string: IMAGE_BASE_URL + imageURL)
        imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "themoviedb"), options:[.transition(.fade(1))])
    }
}
