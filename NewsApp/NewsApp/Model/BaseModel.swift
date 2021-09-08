//
//  BaseModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation

protocol BaseModel: Codable {
    var status: String? { get }
    var code: String? { get }
    var message: String? { get }
}
