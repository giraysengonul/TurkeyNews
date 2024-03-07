//
//  News.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
struct News: Codable{
    let success: Bool
    let result: [ResultModel]
}
struct ResultModel: Codable {
    let key: String
    let url: String
    let description: String
    let image: String
    let name: String
    let source: String
}
