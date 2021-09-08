//
//  ReusableProtocol.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

/// A type that handles cell's reuse identifier to make it easy for users if they forgot to add identifier to a cell.
protocol Reusable {
    /// Cell reuse identifier
    static var reuseIdentifier: String { get }
}

extension Reusable {
    /// To convert and return the class name in string fotmate
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
