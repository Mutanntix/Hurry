//
//  ShopModel.swift
//  Hurry
//
//  Created by Мурад on 10.03.2022.
//

import Foundation

struct ShopModel: Codable {
    let tgChatId: Int?
    let id: String
    var rate: Int
    let menu: [Product]
    let info: Info
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rate, menu, info, tgChatId
    }
}
