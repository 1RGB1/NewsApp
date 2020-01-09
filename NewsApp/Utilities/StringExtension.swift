//
//  StringExtension.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/9/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Foundation

extension String {
    
    func convertDateString() -> String? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormat: "d MMMM yy")
    }

    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {

        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat

        if let fromDateObject = fromDateFormatter.date(from: dateString) {

            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat

            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }

        return nil
    }

}
