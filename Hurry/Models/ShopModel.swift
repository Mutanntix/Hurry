//
//  ShopModel.swift
//  Hurry
//
//  Created by Мурад on 10.03.2022.
//

import Foundation

struct ShopModel: Codable {
    let name: String
    var rating: String
    let country: String
    let city: String
    let address: String
    var products: [Product] = []
}
