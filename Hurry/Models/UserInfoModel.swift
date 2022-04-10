//
//  UserInfoModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 10.04.2022.
//

import Foundation

struct UserInfoModel: Codable {
    let nickname: String
    let favoriteDrink: String
    let country: String
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case nickname, country, city
        case favoriteDrink = "faworiteDrink"
    }
    
    init(offer: UserInfoOfferModel) {
        self.nickname = offer.info.nickname
        self.favoriteDrink = offer.info.favoriteDrink
        self.country = offer.info.country
        self.city = offer.info.city
    }
    
    init?(nick: String,
                     drink: String,
                     country: String,
                     city: String) {
        self.nickname = nick
        self.favoriteDrink = drink
        self.country = country
        self.city = city
    }
}
