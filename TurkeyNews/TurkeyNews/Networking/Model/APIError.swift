//
//  APIError.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

/// API Return Error
struct APIError: Codable {
    let code: Int
    let message: String
}
