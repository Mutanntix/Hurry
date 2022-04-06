//
//  OrdedModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 05.04.2022.
//

import Foundation

struct OrderModel: Codable {
    let chatId: Int
    let order: [[String: Product]]
    let pTime: String
    let bid: String
    let sum: String
    let sw: String
}
