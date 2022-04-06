//
//  ProductModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 02.04.2022.
//

import Foundation

struct Product: Codable {
//    let id: String?
    let title: String
    let option: String
    let price: String
    
    enum CodingKeys: CodingKey {
        case title, option, price
    }
}
