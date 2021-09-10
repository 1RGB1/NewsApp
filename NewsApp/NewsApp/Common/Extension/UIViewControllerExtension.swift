//
//  UIViewControllerExtension.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSFSafariViewControllerFor(url: URL) {
        let safariViewcontroller = SFSafariViewController(url: url)
        present(safariViewcontroller, animated: true, completion: nil)
    }
}
