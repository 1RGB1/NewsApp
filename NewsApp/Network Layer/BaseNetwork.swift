//
//  BaseNetwork.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//
//  This class intended to handle errors description according to errorCode but it already handled in APIs in property message
//  But in future work if we needed to handle other languages and if message is not returned in that language we will map it
//  using code

class BaseNetwork {
    
    func handleError(_ statusCode: Int) -> String {
        switch statusCode {
            case 0:
                return "Success"
            
            default:
                return "Opps, something went wrong"
        }
    }
}
