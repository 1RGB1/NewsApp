//
//  StringExtension.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation

extension String {
    func formatDateLike(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let locale = "US_POSIX"
        dateFormatter.locale = Locale(identifier: locale)
        let dateFromString: Date = dateFormatter.date(from: self) ?? Date()
        return dateFormatter.string(from: dateFromString)
    }
}
